conf="$HyprConfigPath/monitor.conf"

NEW() {
    local internalName=$(hyprctl monitors all | grep "ID 0" | awk '{print $2}')
    local externalName=$(hyprctl monitors all | grep "Monitor" | grep -v "disconnected" | grep -v "ID 0" | awk '{print $2}' | head -n1)

    if [[ -n "$externalName" ]]; then
        echo "monitor=$internalName, disable" > $conf
    else
        echo "" > $conf
    fi
}

#OLD
NEW
