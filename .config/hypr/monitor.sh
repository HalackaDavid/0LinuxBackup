internal="eDP-1"
external=$(hyprctl monitors | grep "Monitor" | grep -v "disconnected" | awk '{print $2}' | grep -v "$internal" | head -n1)

conf="$HOME/.config/hypr/monitor.conf"
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

echo "$HyprConfigPath"
