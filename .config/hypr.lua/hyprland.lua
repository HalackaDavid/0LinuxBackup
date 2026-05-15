-----------------
--- VARIABLES ---
-----------------

local mainMod = SUPER
local configPath = $HOME/.config/hypr
local utilsPath = $configPath/utils
local mediaPath = $HOME/data/Media

local terminal = foot
local menu = wofi  
-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------
hl.env("XCURSOR_SIZE","24")
hl.env("HYPRCURSOR_SIZE","24")

hl.env("NCORConfigPath", configPath)
hl.env("NCORUtilsPath", utilsPath)
hl.env("NCORMediaPath", mediaPath)

------------
- MONITORS -
------------
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

hl.monitor({
  output = "desc: BOE NE160QDM-NYM",
  mode = "2560x1600@60",
  position = "0x0",
  scale = 1.25,
})

---------------
--- STARTUP ---
---------------
hl.on("hyprland.start", function () 
    hl.exec_cmd("$utilsPath/monitor.util && $utilsPath/wallpaper.util 1 && hyprctl dispatch workspace 1 && $terminal")
    hl.exec_cmd("hyprsunset")
end)

--exec-once = $utilsPath/monitor.util && $utilsPath/wallpaper.util 1 && hyprctl dispatch workspace 1 && $terminal

--------------
--- SOURCE ---
--------------
source = $configPath/monitor.conf

-------------------
--- KEYBINDINGS ---
-------------------
hl.bind(mainMod + "Q", hl.exec_cmd(terminal))
hl.bind(mainMod + "R", hl.exec_cmd(menu))

hl.bind(mainMod + "ALT" + "P", exec, $terminal -e $utilsPath/wallpaper.util 0
hl.bind("ALT +F4", killactive)
hl.bind($mainMod SHIFT, L, exec, hyprlock
hl.bind($mainMod, V, togglefloating,
hl.bind($mainMod, P, togglesplit, -- dwindle

-- Keyboard Layout
hl.bind($mainMod, F1, exec, hyprctl switchxkblayout all 0
hl.bind($mainMod, F2, exec, hyprctl switchxkblayout all 1

hl.bind($mainMod, S, exec, $utilsPath/screenshot.util 1
hl.bind($mainMod SHIFT, S, exec, $utilsPath/screenshot.util 2

-- Move focus with mainMod + arrow keys
hl.bind($mainMod, left, movefocus, l
hl.bind($mainMod, right, movefocus, r
hl.bind($mainMod, up, movefocus, u
hl.bind($mainMod, down, movefocus, d

-- Move focus with vim like
hl.bind($mainMod, L, movefocus, l
hl.bind($mainMod, H, movefocus, r
hl.bind($mainMod, K, movefocus, u
hl.bind($mainMod, J, movefocus, d

-- Switch workspaces with mainMod + [0-9]
hl.bind($mainMod, 1, workspace, 1
hl.bind($mainMod, 2, workspace, 2
hl.bind($mainMod, 3, workspace, 3
hl.bind($mainMod, 4, workspace, 4
hl.bind($mainMod, 5, workspace, 5
hl.bind($mainMod, 6, workspace, 6
hl.bind($mainMod, 7, workspace, 7
hl.bind($mainMod, 8, workspace, 8
hl.bind($mainMod, 9, workspace, 9
hl.bind($mainMod, 0, workspace, 10

-- Move active window to a workspace with mainMod + SHIFT + [0-9]
hl.bind($mainMod SHIFT, 1, movetoworkspace, 1
hl.bind($mainMod SHIFT, 2, movetoworkspace, 2
hl.bind($mainMod SHIFT, 3, movetoworkspace, 3
hl.bind($mainMod SHIFT, 4, movetoworkspace, 4
hl.bind($mainMod SHIFT, 5, movetoworkspace, 5
hl.bind($mainMod SHIFT, 6, movetoworkspace, 6
hl.bind($mainMod SHIFT, 7, movetoworkspace, 7
hl.bind($mainMod SHIFT, 8, movetoworkspace, 8
hl.bind($mainMod SHIFT, 9, movetoworkspace, 9
hl.bind($mainMod SHIFT, 0, movetoworkspace, 10

-- Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

-- Laptop multimedia keys for volume and LCD brightness
bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 set 1%+
bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 set 1%-

-- Requires playerctl
bindl = , XF86AudioNext, exec, playerctl next
bindl = , XF86AudioPause, exec, playerctl play-pause
bindl = , XF86AudioPlay, exec, playerctl play-pause
bindl = , XF86AudioPrev, exec, playerctl previous

------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------

windowrule = border_size 0, match:workspace w[t1]

workspace = 1, monitor:HDMI-A-1, default:true
workspace = 2, monitor:HDMI-A-1, default:true
workspace = 3, monitor:HDMI-A-1, default:true
workspace = 4, monitor:HDMI-A-1, default:true
workspace = 5, monitor:HDMI-A-1, default:true
workspace = 6, monitor:HDMI-A-1, default:true
workspace = 7, monitor:HDMI-A-1, default:true
workspace = 9, monitor:HDMI-A-1, default:true
workspace = 10, monitor:HDMI-A-1, default:true

---------------------
--- LOOK AND FEEL ---
---------------------

animations {
    enabled = yes

    -- Default curves, see https://wiki.hypr.land/Configuring/Animations/#curves
    --       NAME,           X0,   Y0,   X1,   Y1
    bezier = easeOutQuint,   0.23, 1,    0.32, 1
    bezier = easeInOutCubic, 0.65, 0.05, 0.36, 1
    bezier = linear,         0,    0,    1,    1
    bezier = almostLinear,   0.5,  0.5,  0.75, 1
    bezier = quick,          0.15, 0,    0.1,  1

    -- Default animations, see https://wiki.hypr.land/Configuring/Animations/
    --          NAME,          ONOFF, SPEED, CURVE,        [STYLE]
    animation = global,        0,     10,    default
    animation = border,        0,     5.39,  easeOutQuint
    animation = windows,       0,     4.79,  easeOutQuint
    animation = windowsIn,     0,     4.1,   easeOutQuint, popin 87%
    animation = windowsOut,    0,     1.49,  linear,       popin 87%
    animation = fadeIn,        0,     1.73,  almostLinear
    animation = fadeOut,       0,     1.46,  almostLinear
    animation = fade,          0,     3.03,  quick
    animation = layers,        0,     3.81,  easeOutQuint
    animation = layersIn,      0,     4,     easeOutQuint, fade
    animation = layersOut,     0,     1.5,   linear,       fade
    animation = fadeLayersIn,  0,     1.79,  almostLinear
    animation = fadeLayersOut, 0,     1.39,  almostLinear
    animation = workspaces,    0,     1.94,  almostLinear, fade
    animation = workspacesIn,  0,     1.21,  almostLinear, fade
    animation = workspacesOut, 0,     1.94,  almostLinear, fade
    animation = zoomFactor,    0,     7,     quick
}

general {
    gaps_in = 5
    gaps_out = 0
    border_size = 1 
    col.active_border = rgba(c9c5c5cc)
    col.inactive_border = rgba(595959aa)
    resize_on_border = false
    layout = dwindle
    --layout = scrolling
}

decoration {
    shadow { 
        enabled = false
    }
    blur { 
        enabled = false
    }
}

scrolling {
    fullscreen_on_one_column = true
    column_width = 0.99
    direction = right

}

dwindle {
    preserve_split = true
    force_split = 2
}

xwayland {
    force_zero_scaling = true
}

misc {
    force_default_wallpaper = 0
    disable_hyprland_logo = true
    initial_workspace_tracking = 2
    vfr = true
}

-------------
--- INPUT ---
-------------

input {
    kb_layout = cz,ru
    kb_variant = coder,
    follow_mouse = 1

    sensitivity = 0 -- -1.0 - 1.0, 0 means no modification.

    touchpad {
        disable_while_typing = 1
        natural_scroll = 1
        clickfinger_behavior = 1 -- --> one finger click - left click | two finger -> right click | three finger -> middle click
    }
}
