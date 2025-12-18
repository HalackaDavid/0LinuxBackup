Wallpaper() {
    if [[ -f $HyprWallpaperPath/wallpaper.active ]]; then
        swaybg -i $HyprWallpaperPath/wallpaper.active -m fill  >/dev/null 2>&1 </dev/null &
    else
        swaybg -c "#000000" -m solid_color  >/dev/null 2>&1 </dev/null &
    fi
}

Kill() {
    killall swaybg 2>/dev/null
}

if [[ $1 == "hypr_scrip" && ${#HyprWallpaperPath} > 0 ]]; then
    Kill
    Wallpaper
    exit
fi

for i in $(ls $HyprWallpaperPath/0); do
    echo "[ ] $i"
done
    echo "[x] Exit"
echo -n ">> "
read UserInput
ln -sf $HyprWallpaperPath/0/$UserInput.png $HyprWallpaperPath/wallpaper.active 
Kill
Wallpaper
