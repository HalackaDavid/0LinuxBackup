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
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(utilsPath .. "/screenshot.util 2"))

-- Keyboard Layout
hl.bind(mainMod .. " + F1", hl.dsp.exec_cmd("hyprctl switchxkblayout all 0"))
hl.bind(mainMod .. " + F2", hl.dsp.exec_cmd("hyprctl switchxkblayout all 1"))

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move focus with vim like
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -n2 set 1%+"),                      { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -n2 set 1%-"),                      { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

------------------------------
--- WINDOWS AND WORKSPACES ---
------------------------------

--hl.window_rule({ match = { class = "workspace w[t1]" }, border_size = 0 })
--windowrule = border_size 0, match:workspace w[t1]

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
        initial_workspace_tracking = 2,
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
]]--

-------------
--- INPUT ---
-------------

input = {
    kb_layout = { "cz", "ru" },
    kb_variant = { "coder", "" },
    follow_mouse = 1,
    sensitivity = 0,

    touchpad = {
        disable_while_typing = 1,
        natural_scroll = 1,
        clickfinger_behavior = 1, -- --> one finger click - left click | two finger -> right click | three finger -> middle click
    },
},
