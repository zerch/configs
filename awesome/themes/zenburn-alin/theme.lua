-------------------------------
--  "Zenburn" awesome theme  --
--    By Adrian C. (anrxc)   --
-------------------------------

-- Alternative icon sets and widget icons:
--  * http://awesome.naquadah.org/wiki/Nice_Icons

-- {{{ Main
local awful = require("awful")
themename     = "zenburn-alin"

theme = {}

home = os.getenv("HOME")
config = awful.util.getdir("config")
themes = config .. "/themes"
themedir = themes .. "/" .. themename

wallpaper_one = themedir .. "/zenburn-background.png"

if awful.util.file_readable(wallpaper_one) then
    theme.wallpaper = wallpaper_one
end

if awful.util.file_readable(config .. "/vain/init.lua") then
    theme.useless_gap_width = "3"
end

--theme.wallpaper_cmd = { "awsetbg " .. wallpaper_one }
-- }}}

-- {{{ Styles
theme.font      = "monospace 10"
theme.taglist_font      = "monospace 12"

-- {{{ Colors
--theme.bg_systray = theme.bg_normal

theme.fg_normal         = "#bdd4a3"
theme.fg_focus          = "#a8d696"
theme.fg_urgent         = "#000000"
theme.fg_minimize       = "#908796"

theme.bg_normal         = "#2d3629"
theme.bg_focus          = "#311833"
theme.bg_urgent         = "#CC3131"
theme.bg_minimize       = "#1a1f16"
theme.bg_systray = theme.bg_normal

-- }}}

-- {{{ Borders
theme.useless_gap   = 0
theme.border_width  = "0"
theme.border_normal = "#322736"
theme.border_focus  = "#2b3627"
theme.border_marked = "#2f421d"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#3F3F3F"
theme.titlebar_bg_normal = "#3F3F3F"
-- }}}

theme.taglist_bg_focus = "#220924"
theme.taglist_fg_focus = "#805bbd"

theme.tasklist_bg_focus = "#111430"
theme.tasklist_fg_focus = "#876e44"

theme.tooltip_font = "monospace 8"
theme.tooltip_opacity = 100
theme.tooltip_fg_color = "#FF5c5c"
theme.tooltip_bg_color = "#2e5c5c"

-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#b80000"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = "10"
theme.menu_width  = "100"
theme.menu_border_width = "1"
theme.menu_fg_normal    = "#aaaaaa"   --color txt pip
theme.menu_fg_focus     = "#7788af"
theme.menu_bg_normal    = "#080808"   --background menu
theme.menu_bg_focus     = "#080808"
-- }}}

-- {{{ Icons

-- {{{ Taglist
theme.taglist_squares_sel   = themedir .. "/taglist/squaref_b.png"
theme.taglist_squares_unsel = themedir .. "/taglist/square_b.png"
theme.taglist_squares_resize = "true"
-- }}}

-- {{{  Widget icons

theme.widget_uptime     = themedir .. "/widgets/green/ac_01.png"
theme.widget_cpu        = themedir .. "/widgets/green/cpu.png"
theme.widget_temp       = themedir .. "/widgets/green/temp.png"
theme.widget_mem        = themedir .. "/widgets/green/mem.png"
theme.widget_fs         = themedir .. "/widgets/green/usb.png"
theme.widget_netdown    = themedir .. "/widgets/green/net_down_03.png"
theme.widget_netup      = themedir .. "/widgets/green/net_up_03.png"
theme.widget_gmail      = themedir .. "/widgets/green/mail.png"
theme.widget_sys        = themedir .. "/widgets/green/dish.png"
theme.widget_pac        = themedir .. "/widgets/green/pacman.png"
theme.widget_batt       = themedir .. "/widgets/green/bat_full_01.png"
theme.widget_clock      = themedir .. "/widgets/green/clock.png"
theme.widget_vol        = themedir .. "/widgets/green/spkr_01.png"

-- }}}

-- {{{ Misc
theme.awesome_icon           = themedir .. "/awesome-icon.png"
theme.menu_submenu_icon      = "/usr/share/awesome/themes/default/submenu.png"
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

-- {{{ Titlebar
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

return theme
