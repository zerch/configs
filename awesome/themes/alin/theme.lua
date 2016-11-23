-- zenburn-red, awesome3 theme, by Adrian C. (anrxc), modified by jessor
-- alin's custom theme
--{{{ Main

local awful = require("awful")
awful.util = require("awful.util")

theme = {}

home          = os.getenv("HOME")
config        = awful.util.getdir("config")
--config        = "/home/apavalas/.config/awesome"
themes        = config .. "/themes"
themename     = "/alin"
themedir      = themes .. themename

wallpaper1    = themedir .. "/zenburn-background.jpg"
wallpaper2    = themedir .. "/zenburn-background.png"

if awful.util.file_readable(wallpaper1) then
    theme.wallpaper = wallpaper1
else
    theme.wallpaper = wallpaper2
end
if awful.util.file_readable(config .. "/vain/init.lua") then
    theme.useless_gap_width  = "3"
end
--}}}


-- {{{ Styles
theme.font      = "Monospace 10"

-- {{{ Colors

theme.bg_systray = theme.bg_normal

theme.fg_normal = "#DCDCCC"
theme.fg_focus  = "#FFFFFF"
theme.fg_urgent = "#BC0909"
theme.bg_minimize   = "#080808"

theme.bg_normal = "#181818"
theme.bg_focus  = "#400000"
theme.bg_urgent = theme.bg_normal
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

theme.fg_widget        = "#9ACD32" -- low
theme.fg_center_widget = "#de8120"
theme.fg_end_widget    = "#c22313" -- high
theme.fg_off_widget    = theme.bg_normal -- bg
theme.fg_netup_widget  = "#9ACD32"
theme.fg_netdn_widget  = theme.border_focus
theme.bg_widget        = theme.bg_urgent 
theme.border_widget    = theme.bg_urgent

theme.titlebar_bg_focus  = theme.bg_normal
theme.titlebar_bg_normal = theme.bg_normal

-- }}}

-- {{{ Borders

theme.border_width  = 0
theme.border_focus  = "#EE6363"
theme.border_normal = theme.bg_normal 
theme.border_marked = "#622323"

-- }}}

theme.mouse_finder_color = theme.fg_urgent
-- {{{ Menu

theme.menu_height       = "12"
theme.menu_width        = "105"
theme.menu_border_width = "1"
theme.menu_fg_normal    = "#aaaaaa"   --color txt pip
theme.menu_fg_focus     = "#7788af"
theme.menu_bg_normal    = "#080808"   --background menu
theme.menu_bg_focus     = "#080808"

-- }}}

-- {{{ Icons

-- {{{  Widget icons

theme.widget_uptime     = themedir .. "/widgets/red/ac_01.png"
theme.widget_cpu        = themedir .. "/widgets/red/cpu.png"
theme.widget_temp       = themedir .. "/widgets/red/temp.png"
theme.widget_mem        = themedir .. "/widgets/red/mem.png"
theme.widget_fs         = themedir .. "/widgets/red/usb.png"
theme.widget_netdown    = themedir .. "/widgets/red/net_down_03.png"
theme.widget_netup      = themedir .. "/widgets/red/net_up_03.png"
theme.widget_gmail      = themedir .. "/widgets/red/mail.png"
theme.widget_sys        = themedir .. "/widgets/red/dish.png"
theme.widget_pac        = themedir .. "/widgets/red/pacman.png"
theme.widget_batt       = themedir .. "/widgets/red/bat_full_01.png"
theme.widget_clock      = themedir .. "/widgets/red/clock.png"
theme.widget_vol        = themedir .. "/widgets/red/spkr_01.png"

-- }}}

-- {{{ Taglist

theme.taglist_squares_sel   = themedir .. "/taglist/squarefz.png"
theme.taglist_squares_unsel = themedir .. "/taglist/squareza.png"

--theme.taglist_squares_resize = "false"

-- }}}

-- {{{ Misc

theme.tasklist_floating_icon = themedir .. "/floating.png"

-- }}}

-- {{{ Layout

theme.layout_tile       = themedir .. "/layouts/tile.png"
theme.layout_tileleft   = themedir .. "/layouts/tileleft.png"
theme.layout_tilebottom = themedir .. "/layouts/tilebottom.png"
theme.layout_tiletop    = themedir .. "/layouts/tiletop.png"
theme.layout_fairv      = themedir .. "/layouts/fairv.png"
theme.layout_fairh      = themedir .. "/layouts/fairh.png"
theme.layout_spiral     = themedir .. "/layouts/spiral.png"
theme.layout_dwindle    = themedir .. "/layouts/dwindle.png"
theme.layout_max        = themedir .. "/layouts/max.png"
theme.layout_fullscreen = themedir .. "/layouts/fullscreen.png"
theme.layout_magnifier  = themedir .. "/layouts/magnifier.png"
theme.layout_floating   = themedir .. "/layouts/floating.png"

-- }}}


-- {{{ Titlebar icons
theme.titlebar_close_button_focus  = themedir .. "/titlebar/close_focus.png"
theme.titlebar_close_button_normal = themedir .. "/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active    = themedir .. "/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active   = themedir .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = themedir .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = themedir .. "/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active    = themedir .. "/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active   = themedir .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = themedir .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = themedir .. "/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active    = themedir .. "/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active   = themedir .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = themedir .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = themedir .. "/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active    = themedir .. "/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active   = themedir .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = themedir .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = themedir .. "/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}


return theme
