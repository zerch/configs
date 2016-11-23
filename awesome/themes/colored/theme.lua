
-- {{{ Main

local awful = require("awful")
awful.util = require("awful.util")

theme = {}

home          = os.getenv("HOME")
config        = awful.util.getdir("config")
themes        = config .. "/themes"
themename     = "/alin"
themedir      = themes .. themename

wallpaper1    = themedir .. "/background.jpg"
wallpaper2    = themedir .. "/background.png"

if awful.util.file_readable(wallpaper1) then
    theme.wallpaper = wallpaper1
else
    theme.wallpaper = wallpaper2
end
-- }}}

-- {{{ Font

theme.font      = "Termsyn 14"

-- }}}

-- {{{ Colors

-- theme.bg_systray = theme.bg_normal

theme.bg_normal     = "#080808"
theme.bg_focus      = "#080808"
theme.bg_urgent     = "#080808"
theme.bg_minimize   = "#080808"

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#7788af"
theme.fg_urgent     = "#94738c"
theme.fg_minimize   = "#444444"

theme.fg_black      = "#424242"
theme.fg_red        = "#ce5666"
theme.fg_green      = "#80a673"
theme.fg_yellow     = "#ffaf5f"
theme.fg_blue       = "#7788af"
theme.fg_magenta    = "#94738c"
theme.fg_cyan       = "#778baf"
theme.fg_white      = "#aaaaaa"
theme.fg_blu        = "#8ebdde"

-- }}}

-- {{{ Borders

theme.border_width  = 1
theme.border_normal = "#202020"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

-- }}}

-- {{{ Menu

theme.menu_height       = "8"
theme.menu_width        = "105"
theme.menu_border_width = "0"
theme.menu_fg_normal    = "#aaaaaa"   --color txt pip
theme.menu_fg_focus     = "#7788af"
theme.menu_bg_normal    = "#080808"   --background menu
theme.menu_bg_focus     = "#080808"

-- }}}

-- {{{ Icons

-- {{{  Widget icons

theme.widget_uptime     = theme.confdir .. "/widgets/red/ac_01.png"
theme.widget_cpu        = theme.confdir .. "/widgets/red/cpu.png"
theme.widget_temp       = theme.confdir .. "/widgets/red/temp.png"
theme.widget_mem        = theme.confdir .. "/widgets/red/mem.png"
theme.widget_fs         = theme.confdir .. "/widgets/red/usb.png"
theme.widget_netdown    = theme.confdir .. "/widgets/red/net_down_03.png"
theme.widget_netup      = theme.confdir .. "/widgets/red/net_up_03.png"
theme.widget_gmail      = theme.confdir .. "/widgets/red/mail.png"
theme.widget_sys        = theme.confdir .. "/widgets/red/dish.png"
theme.widget_pac        = theme.confdir .. "/widgets/red/pacman.png"
theme.widget_batt       = theme.confdir .. "/widgets/red/bat_full_01.png"
theme.widget_clock      = theme.confdir .. "/widgets/red/clock.png"
theme.widget_vol        = theme.confdir .. "/widgets/red/spkr_01.png"

-- }}}

-- {{{ Taglist

theme.taglist_squares_sel   = theme.confdir .. "/taglist/squaref_b.png"
theme.taglist_squares_unsel = theme.confdir .. "/taglist/square_b.png"

--theme.taglist_squares_resize = "false"

-- }}}

-- {{{ Misc

theme.tasklist_floating_icon = theme.confdir .. "/floating.png"

-- }}}

-- {{{ Layout

theme.layout_tile       = theme.confdir .. "/layouts/tile.png"
theme.layout_tileleft   = theme.confdir .. "/layouts/tileleft.png"
theme.layout_tilebottom = theme.confdir .. "/layouts/tilebottom.png"
theme.layout_tiletop    = theme.confdir .. "/layouts/tiletop.png"
theme.layout_fairv      = theme.confdir .. "/layouts/fairv.png"
theme.layout_fairh      = theme.confdir .. "/layouts/fairh.png"
theme.layout_spiral     = theme.confdir .. "/layouts/spiral.png"
theme.layout_dwindle    = theme.confdir .. "/layouts/dwindle.png"
theme.layout_max        = theme.confdir .. "/layouts/max.png"
theme.layout_fullscreen = theme.confdir .. "/layouts/fullscreen.png"
theme.layout_magnifier  = theme.confdir .. "/layouts/magnifier.png"
theme.layout_floating   = theme.confdir .. "/layouts/floating.png"

-- }}}

-- }}}

return theme
