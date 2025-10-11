#!/usr/bin/env python3
import os, sys, time, json, urllib.parse, threading, queue
from http.server import HTTPServer, BaseHTTPRequestHandler

OUTPUT_FILE   = "/home/weston/sensors.csv"
BIND_HOST     = "0.0.0.0"
BIND_PORT     = 8000

THROTTLE_SEC   = 0.0
ONLY_ON_CHANGE = False
MAX_BODY_BYTES = 65536
REQUEST_TIMEOUT = 10  # seconds

last_write_ts = 0.0
last_row      = ""
last_time     = ""
last_value    = None
write_queue   = queue.Queue(maxsize=10)  # async write queue

def write_worker():
    """Background thread that handles all file writes"""
    while True:
        try:
            row = write_queue.get(timeout=1)
            if row is None:  # sentinel value to exit
                break
            d = os.path.dirname(OUTPUT_FILE) or "."
            os.makedirs(d, exist_ok=True)
            with open(OUTPUT_FILE, "w") as f:
                f.write(row + "\n")
            print(f"[WRITE] {row}", file=sys.stderr)
        except queue.Empty:
            continue
        except Exception as e:
            print(f"[ERROR] Write failed: {e}", file=sys.stderr)

class Handler(BaseHTTPRequestHandler):
    timeout = REQUEST_TIMEOUT

    def log_message(self, fmt, *args):
        return

    def _send(self, code=200, body=b"", ctype="text/plain"):
        self.send_response(code)
        self.send_header("Content-Type", ctype)
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        if body:
            self.wfile.write(body)

    def do_GET(self):
        if self.path == "/ping":
            return self._send(200, b"pong\n")
        if self.path == "/latest":
            return self._send(200, (last_row + "\n").encode())
        return self._send(404, b"not found\n")

    def do_POST(self):
        global last_write_ts, last_row, last_time, last_value

        if self.path != "/data":
            return self._send(404, b"not found\n")

        try:
            length = int(self.headers.get("Content-Length", "0"))
        except Exception:
            return self._send(411, b"missing content-length\n")
        if length <= 0 or length > MAX_BODY_BYTES:
            return self._send(413, b"payload too large or empty\n")

        ctype = (self.headers.get("Content-Type") or "").split(";")[0].strip()
        raw = self.rfile.read(length)
        print(f"[REQ] len={length} ctype={ctype} path={self.path}", file=sys.stderr)

        try:
            if ctype == "application/json":
                data = json.loads(raw.decode("utf-8", errors="replace"))
            elif ctype in ("application/x-www-form-urlencoded", "text/plain"):
                form = urllib.parse.parse_qs(raw.decode("utf-8", errors="replace"))
                payload_text = None
                for k in ("data", "payload", "json"):
                    if k in form and form[k]:
                        payload_text = form[k][0]
                        break
                if payload_text is None:
                    return self._send(400, b"no JSON field found\n")
                data = json.loads(payload_text)
            else:
                data = json.loads(raw.decode("utf-8", errors="replace"))
        except Exception as e:
            return self._send(400, f"invalid json: {e}\n".encode())

        try:
            payload = data.get("payload", data if isinstance(data, dict) else [])
            compass_val = None
            if isinstance(payload, list):
                for item in payload:
                    if isinstance(item, dict) and item.get("name") == "compass":
                        compass_val = round(float(item.get("values", {}).get("magneticBearing", 0.0)), 2)
                        break
            elif isinstance(payload, dict):
                compass_val = round(float(payload.get("magneticBearing", 0.0)), 2)
            if compass_val is None:
                compass_val = 0.0
        except Exception as e:
            return self._send(400, f"bad payload: {e}\n".encode())

        now_str = time.strftime("%H:%M:%S")
        row = f"compass,{compass_val},time,{now_str}"

        t = time.time()
        should_write = (t - last_write_ts >= THROTTLE_SEC)
        if ONLY_ON_CHANGE:
            should_write = should_write and (compass_val != last_value or now_str != last_time)

        if should_write:
            try:
                write_queue.put_nowait(row)  # non-blocking queue put
                last_write_ts = t
                last_value = compass_val
                last_time = now_str
            except queue.Full:
                print(f"[WARN] Write queue full, dropping update", file=sys.stderr)

        last_row = row
        return self._send(200, b"OK\n")

if __name__ == "__main__":
    # Start background write worker
    worker_thread = threading.Thread(target=write_worker, daemon=True)
    worker_thread.start()

    srv = HTTPServer((BIND_HOST, BIND_PORT), Handler)
    print(f"[INFO] listening on {BIND_HOST}:{BIND_PORT}, writing to {OUTPUT_FILE}", file=sys.stderr)
    try:
        srv.serve_forever()
    except KeyboardInterrupt:
        write_queue.put(None)  # signal worker to exit
        worker_thread.join(timeout=2)
        srv.server_close()