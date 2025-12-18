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

HyprWallpaperPath=""

if [[ $1 == "hypr_script" && ${#HyprWallpaperPath} > 0 ]]; then
    Kill
    Wallpaper
    exit
elif [[ ${#HyprWallpaperPath} > 0 ]]; then

    for i in $(ls $HyprWallpaperPath/0); do
        echo "[ ] $i"
    done
        echo "[x] Exit"
    echo -n ">> "
    read UserInput
    ln -sf "$HyprWallpaperPath/0/$UserInput".* "$HyprWallpaperPath/wallpaper.active"
    Kill
    Wallpaper
    sleep 0.1 #Broken without
fi
