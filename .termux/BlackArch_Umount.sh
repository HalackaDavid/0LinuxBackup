MNT="/data/local/BlackArch/rootfsBlackArch"

umount -l "$MNT/dev/pts" 2>/dev/null
umount -l "$MNT/dev/shm" 2>/dev/null
umount -l "$MNT/cache" 2>/dev/null
umount -l "$MNT/sdcard" 2>/dev/null
umount -l "$MNT/sys" 2>/dev/null
umount -l "$MNT/proc" 2>/dev/null
umount -l "$MNT/dev" 2>/dev/null
umount -l "$MNT/data" 2>/dev/null

