#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>

/*
[chromagor@blackarch]-[~/.config/hypr]
>>> ./a.out
Monitor unplugged: eDP-1
Monitor unplugged: HDMI-A-1
Monitor unplugged: HDMI-A-1
Monitor unplugged: eDP-1
Monitor unplugged: HDMI-A-1
Monitor unplugged: FALLBACK
*/

int main() {
    struct Profile {
        int profile_number;
        char monitorName[64];

    };
    const char* hyprConfigPath = getenv("HyprConfigPath");
    const char* sock_path = getenv("XDG_RUNTIME_DIR");
    char path[256];
    snprintf(path, sizeof(path), "%s/hypr/%s/.socket2.sock", sock_path, getenv("HYPRLAND_INSTANCE_SIGNATURE"));
    printf("%s\n%s\n%s", hyprConfigPath, sock_path, path);
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
//        if (strncmp(buffer, "monitorremoved>>", 16) == 0) {
//            printf("Monitor unplugged: %s %s", buffer + 16, hyprConfigPath);
//        }
//    }
//    close(sock);
    return 0;
}
