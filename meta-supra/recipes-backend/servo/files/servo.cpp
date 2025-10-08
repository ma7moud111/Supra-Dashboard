#include <fcntl.h>
#include <termios.h>
#include <unistd.h>

#include <fstream>
#include <iostream>
#include <string>

int main() {
    const char *port = "/dev/ttyACM0";
    int serial_port = open(port, O_RDWR);

    if (serial_port < 0) {
        std::cerr << "Error opening serial port " << port << std::endl;
        return 1;
    }

    termios tty{};
    tcgetattr(serial_port, &tty);
    cfsetispeed(&tty, B115200);
    cfsetospeed(&tty, B115200);
    tty.c_cflag |= (CLOCAL | CREAD);
    tty.c_cflag &= ~CSIZE;
    tty.c_cflag |= CS8;
    tty.c_cflag &= ~PARENB;
    tty.c_cflag &= ~CSTOPB;
    tty.c_cflag &= ~CRTSCTS;
    tty.c_lflag = 0;
    tty.c_oflag = 0;
    tty.c_iflag = 0;
    tty.c_cc[VMIN] = 1;
    tty.c_cc[VTIME] = 1;
    tcsetattr(serial_port, TCSANOW, &tty);

    char buf[256];
    std::ofstream csv("/home/weston/data.csv", std::ios::trunc);

    if (csv.is_open()) {
        csv << "pot,948,servo,90,temp,30";
        csv.close();
    }

    while (true) {
        int n = read(serial_port, buf, sizeof(buf) - 1);
        if (n > 0) {
            buf[n] = '\0';
            std::string line(buf);

            // Truncate file and write only the latest line
            std::ofstream csv("/home/weston/data.csv", std::ios::trunc);
            if (csv.is_open()) {
                if(line.length() > 0)
                    csv << line;
                csv.close();
            }

            std::cout << "Updated: " << line;
        }
    }

    close(serial_port);
    return 0;
}
