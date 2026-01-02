conf="$HyprConfigPath/monitor.conf"

OLD() {

internal="eDP-1"
external=$(hyprctl monitors all | grep "Monitor" | grep -v "disconnected" | awk '{print $2}' | grep -v "$internal" | head -n1)

#echo "" > $conf

if [[ -n "$external" ]]; then
cat <<EOF > "$conf"
monitor=$external,1920x1080@60,0x0,1
monitor=$internal,disable
EOF
else
cat <<EOF > "$conf"
monitor=$internal,1920x1080@60,0x0,1
EOF
fi

echo "$HyprConfigPath/monitor.conf"
}

NEW() {
    local internalName=$(hyprctl monitors all | grep "ID 0" | awk '{print $2}')
    local externalName=$(hyprctl monitors all | grep "Monitor" | grep -v "disconnected" | grep -v "ID 0" | awk '{print $2}' | head -n1)

    if [[ -n "$externalName" ]]; then
        echo "monitor=$internalName,disable" > $conf
    else
        echo "" > $conf
    fi
}

#OLD
NEW

hyprctl reload
unset conf
