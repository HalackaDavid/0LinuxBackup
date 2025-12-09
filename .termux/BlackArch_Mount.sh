MNT="/data/local/BlackArch/rootfsBlackArch"

busybox mount -o remount,dev,suid /data

mkdir -p "$MNT"/{dev,proc,sys,dcard,cache,data}

busybox mount -o bind /dev "$MNT/dev"
busybox mount -o bind /proc "$MNT/proc"
busybox mount -o bind /sys "$MNT/sys"
busybox mount -o bind /sdcard "$MNT/sdcard"
busybox mount -o bind /dev/pts "$MNT/dev/pts"
busybox mount -o bind /data "$MNT/data"
busybox mount -t tmpfs tmpfs "$MNT/cache"

mkdir -p "$MNT/dev/shm"
busybox mount -t tmpfs -o size=256M tmpfs "$MNT/dev/shm"
