Wallpaper() {
    if [[ -f $HyprWallpaperPath/wallpaper.active ]]; then
        setsid swaybg -i $HyprWallpaperPath/wallpaper.active -m fill  >/dev/null 2>&1 </dev/null &
    else
        setsid swaybg -c "#000000" -m solid_color  >/dev/null 2>&1 </dev/null &
    fi
}

Kill() {
    pkill -x swaybg 2>/dev/null
}

if [[ $1 == "hypr_script" && ${#HyprWallpaperPath} > 0 ]]; then
    Kill
    Wallpaper
    exit
elif [[ ${#HyprWallpaperPath} > 0 ]]; then
    found=0
    for i in $(ls $HyprWallpaperPath/0); do
        if [[ $HyprWallpaperPath/wallpaper.active -ef $HyprWallpaperPath/0/$i ]]; then
            echo "[*] $i"
            found=1
        else
            echo "[-] $i"
        fi
    done
        if [[ $found == 0 ]]; then
            echo "[*] Black"
        else
            echo "[-] Black"
        fi
    echo -n ">>> "
    read UserInput
    [ "$UserInput" = "" ] && exit 0
    ln -sf "$HyprWallpaperPath/0/$UserInput".* "$HyprWallpaperPath/wallpaper.active"
    Kill
    Wallpaper
    unset UserInput
    unset i
    unset found
    sleep 0.1 #Broken without
else
    echo "Wallpapar Path has 0 lenght."
    echo "[Enter] to exit...."
    read
fi
