// gpio_buttons_leds.cpp (for custom gpiomod driver)
// Compile: g++ -std=c++17 gpio_buttons_leds.cpp -o gpio_buttons_leds
// Run: sudo ./gpio_buttons_leds

#include <bits/stdc++.h>
#include <csignal>
#include <unistd.h>
using namespace std;

// ---- Pins ----
vector<int> buttonPins = {5, 6, 13, 19, 26};  // buttons (inputs)
vector<int> ledPins    = {17, 27};            // LEDs (outputs)
vector<int> buttonToLed = {0, 1};             // mapping button→LED

const string CSV_FILE = "/home/weston/buttons_log.csv";
volatile sig_atomic_t keep_running = 1;

void sigint_handler(int) { keep_running = 0; }

// ---------- File Utilities ----------
bool write_file(const string &path, const string &value) {
    ofstream ofs(path);
    if (!ofs.is_open()) return false;
    ofs << value;
    return true;
}

string read_file(const string &path) {
    ifstream ifs(path);
    if (!ifs.is_open()) return "";
    string s; getline(ifs, s);
    return s;
}

bool file_exists(const string &path) { return access(path.c_str(), F_OK) == 0; }

// ---------- GPIO Utilities ----------
bool set_direction(int gpio, const string &dir) {
    string path = "/sys/class/gpiomod/gpio" + to_string(gpio) + "/direction";
    return write_file(path, dir);
}

bool set_value(int gpio, int val) {
    string path = "/sys/class/gpiomod/gpio" + to_string(gpio) + "/value";
    return write_file(path, to_string(val));
}

int read_value(int gpio) {
    string path = "/sys/class/gpiomod/gpio" + to_string(gpio) + "/value";
    string s = read_file(path);
    if (s.empty()) return -1;
    return (s[0] == '0') ? 0 : 1;
}

bool set_pullup(int gpio, int enable) {
    string path = "/sys/class/gpiomod/gpio" + to_string(gpio) + "/pull_up";
    return write_file(path, to_string(enable));
}

bool set_pulldown(int gpio, int enable) {
    string path = "/sys/class/gpiomod/gpio" + to_string(gpio) + "/pull_down";
    return write_file(path, to_string(enable));
}

// ---------- MAIN ----------
int main() {
    ios::sync_with_stdio(false);
    cin.tie(nullptr);

    struct sigaction sa;
    sa.sa_handler = sigint_handler;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;
    sigaction(SIGINT, &sa, nullptr);

    cout << "App running with custom gpiomod driver (/sys/class/gpiomod/...)\n";
    cout << "Press Ctrl+C to exit...\n";

    // ---- Setup Buttons (input + pull-up) ----
    for (int gpio : buttonPins) {
        set_direction(gpio, "in");
        set_pulldown(gpio, 0); // ensure pulldown disabled
        set_pullup(gpio, 1);   // enable pull-up
    }

    // ---- Setup LEDs (output) ----
    for (int gpio : ledPins) {
        set_direction(gpio, "out");
        set_value(gpio, 0); // start OFF
    }

    vector<int> ledState(ledPins.size(), 0);
    vector<int> lastButtonState(buttonPins.size(), 0);
    const int POLL_MS = 200;

    while (keep_running) {
        vector<int> vals;

        for (size_t i = 0; i < buttonPins.size(); i++) {
            int v = read_value(buttonPins[i]);
            if (v < 0) v = 0;
            vals.push_back(v);

            // Button-to-LED mapping
            for (size_t m = 0; m < buttonToLed.size(); m++) {
                if ((int)i == buttonToLed[m]) {
                    if (lastButtonState[i] == 1 && v == 0) { // pressed (active low)
                        ledState[m] = !ledState[m];
                        set_value(ledPins[m], ledState[m]);
                    }
                }
            }
        }

        cout << "\rButtons: ";
        for (size_t i = 0; i < vals.size(); ++i) {
            cout << vals[i];
            if (i + 1 < vals.size()) cout << " ";
        }
        cout << "   " << flush;

        // ---- Log to CSV ----
// ---- Log latest values to CSV ----
ofstream csv(CSV_FILE, ios::trunc);  // overwrite each time (keep only latest)
if (csv.is_open()) {
    // Write header once each overwrite (since file is small)
    for (size_t i = 0; i < buttonPins.size(); ++i) {
        csv << "button" << (i + 1);
        if (i + 1 < buttonPins.size()) csv << ",";
    }
    csv << "\n";

    // Write current values
    for (size_t i = 0; i < vals.size(); ++i) {
        csv << vals[i];
        if (i + 1 < vals.size()) csv << ",";
    }
    csv << "\n";

    csv.flush();  // force immediate write to disk
}


        lastButtonState = vals;
        this_thread::sleep_for(chrono::milliseconds(POLL_MS));
    }

    cout << "\nProgram terminated. CSV saved to " << CSV_FILE << "\n";
    return 0;
}
