#include <stdio.h>
#include <termios.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdlib.h>

int main (int argc, const char* argv[]) {
    if (argc != 2) {
        printf("usage: %s <serial>\n", argv[0]);
        return 1;
    }

    int fd = open(argv[1], O_RDWR);
    if (fd < 0) {
        printf("Failed to open %s\n", argv[1]);
        return 2;
    }

    if (tcflush(fd, TCIOFLUSH) < 0) {
        printf("Failed to flush %s\n", argv[1]);
        return 2;
    }

    close(fd);

    return 0;
}
