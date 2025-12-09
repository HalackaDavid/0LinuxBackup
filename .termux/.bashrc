#https://www.baeldung.com/linux/use-command-line-arguments-in-bash-script
LINUX="BlackArch"
PRG_HOME="/data/data/com.termux/files/home/.termux"

while true; do
    clear
    su -c sh $PRG_HOME/$LINUX"_ChrootStatus.sh"
    echo ""
    echo "[1] Mount"
    echo "[2] Umount"
    echo "[3] Chroot"
    echo "[4] Shell"
    echo "[x] Exit"
    echo -n ">>> "
    
    read UserInput
    clear
    case $UserInput in
    1) PRG="Mount.sh";;
    2) PRG="Umount.sh";;
    3) PRG="Chroot.sh";;
    4) break;;
    x) exit;;
    esac
    su -c sh $PRG_HOME/$LINUX"_"$PRG
done
