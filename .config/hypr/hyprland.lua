-----------------
--- VARIABLES ---
-----------------
local HOME = os.getenv("HOME")
local mainMod = "SUPER"
local configPath = HOME .. "/.config/hypr"
local utilsPath = configPath .. "/utils"
local mediaPath = HOME .. "/data/Media"

local terminal = "foot"
local menu = "wofi"
-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------
hl.env("XCURSOR_SIZE","24")
hl.env("HYPRCURSOR_SIZE","24")

hl.env("NCORConfigPath", configPath)
hl.env("NCORUtilsPath", utilsPath)
hl.env("NCORMediaPath", mediaPath)

--------------
-- MONITORS --
--------------
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
    hl.exec_cmd(utilsPath .. "/monitor.util & " .. utilsPath .. "/wallpaper.util 1 & hyprctl dispatch workspace 1 & " .. terminal)
    hl.exec_cmd("hyprsunset")
end)
--exec-once = $utilsPath/monitor.util && $utilsPath/wallpaper.util 1 && hyprctl dispatch workspace 1 && $terminal

--------------
--- SOURCE ---
--------------
--source = $configPath/monitor.conf

-------------------
--- KEYBINDINGS ---
-------------------
hl.bind(mainMod .. " + Q",       hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + R",       hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + ALT + P", hl.dsp.exec_cmd(terminal .. " -e " .. utilsPath .. "/wallpaper.util 0"))
hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + V", hl.dsp.window.float())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) 
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd(utilsPath .. "/screenshot.util 1"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(utilsPath .. "/screenshot.util 2")

-- Keyboard Layout
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("hyprctl switchxkblayout all 0")
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd("hyprctl switchxkblayout all 1")

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ destination = "left" })
hl.bind(mainMod .. " + right", hl.dsp.focus({ destination = "right" })
hl.bind(mainMod .. " + up", hl.dsp.focus({ destination = "up" })
hl.bind(mainMod .. " + down", hl.dsp.focus({ destination = "down" })

--[[
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
]]--
---------------------
--- LOOK AND FEEL ---
---------------------

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 0,
        border_size = 1,
        col = {
            active_border = "rgba(c9c5c5cc)",
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        shadow = {enabled = false,},
        blur = {enabled = false,},
    },

    xwayland = {
        enabled = true,
        force_zero_scaling = false,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true,
        initial_workspace_tracking = 2
    },

    debug = {
        vfr = true,
    },

    animations = {enabled = false,},
})

--[[
scrolling {
    fullscreen_on_one_column = true
    column_width = 0.99
    direction = right

}

dwindle {
    preserve_split = true
    force_split = 2
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
]]--
