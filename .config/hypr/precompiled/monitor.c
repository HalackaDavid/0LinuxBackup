//#include <sys/socket.h>
//#include <sys/un.h>
//#include <unistd.h>
//#include <stdio.h>
//#include <stdlib.h>
//
//
///*
//    dynamic monitor assigner {
//        lang c
//        IPC usage
//        profiler {
//            default {}
//            per_monitor {}
//        }
//    }
//*/
//
///*
//    [chromagor@blackarch]-[~/.config/hypr]
//    >>> ./a.out
//    Monitor unplugged: eDP-1
//    Monitor unplugged: HDMI-A-1
//    Monitor unplugged: HDMI-A-1
//    Monitor unplugged: eDP-1
//    Monitor unplugged: HDMI-A-1
//    Monitor unplugged: FALLBACK
//*/
//
//int main() {
//    const char* hyprConfigPath = getenv("NCORConfigPath");
//    const char* sock_path = getenv("XDG_RUNTIME_DIR");
//    char path[256];
//    snprintf(path, sizeof(path), "%s/hypr/%s/.socket2.sock", sock_path, getenv("HYPRLAND_INSTANCE_SIGNATURE"));
//    printf("%s\n%s\n%s\n", hyprConfigPath, sock_path, path);
//
//    int sock = socket(AF_UNIX, SOCK_STREAM, 0);
//    struct sockaddr_un addr = {0};
//    addr.sun_family = AF_UNIX;
//    strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);
//
//    if (connect(sock, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
//        perror("connect");
//        return 1;
//    }
//    
//    char buffer[1024];
//    while (fgets(buffer, sizeof(buffer), fdopen(sock, "r"))) {
//        printf("AAAAAAA: %s\n");
//
//        if (strncmp(buffer, "monitorremoved>>", 16) == 0) {
//            printf("Monitor unplugged: %s", buffer + 16);
//        }
//
//        if (strncmp(buffer, "monitoradded>>", 14) == 0) {
//            printf("Monitor added: %s", buffer + 14);
//        }
//    }
//    close(sock);
//    return 0;
//}
//
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/socket.h>
#include <sys/un.h>

int main() {
    const char* sock_path = getenv("XDG_RUNTIME_DIR");
    const char* instance_sig = getenv("HYPRLAND_INSTANCE_SIGNATURE");
    char path[256];
    snprintf(path, sizeof(path), "%s/hypr/%s/.socket2.sock", sock_path, instance_sig);

    int sock = socket(AF_UNIX, SOCK_STREAM, 0);
    struct sockaddr_un addr = {0};
    addr.sun_family = AF_UNIX;
    strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1);

    if (connect(sock, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
        perror("connect");
        return 1;
    }

    char buffer[4096];
    ssize_t bytesRead;
    while ((bytesRead = read(sock, buffer, sizeof(buffer) - 1)) > 0) {
        buffer[bytesRead] = '\0';
        char* line = strtok(buffer, "\n");
        while (line != NULL) {
            //printf("EVENT: %s\n", line);
            if (strncmp(line, "monitoradded>>", 14) == 0) {
                printf("Monitor added: %s\n", line + 14);
            } else if (strncmp(line, "monitorremoved>>", 16) == 0) {
                printf("Monitor removed: %s\n", line + 16);
            }
            line = strtok(NULL, "\n");
        }
    }

    close(sock);
    return 0;
}   
