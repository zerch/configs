-- Standard awesome library
local gears         = require("gears")
local awful         = require("awful")
      awful.rules         = require("awful.rules")
require("awful.autofocus")

-- Widget and layout library
local wibox         = require("wibox")

-- Theme handling library
local beautiful     = require("beautiful")

-- Notification library
local naughty       = require("naughty")
local menubar       = require("menubar")

-- Vicious library
vicious = require("vicious")

-- BlingBling library
blingbling = require("blingbling")

-- {{{ Autostart
function run_once(cmd)
    findme = cmd
    firstspace = cmd:find(" ")
    if firstspace then
        findme = cmd:sub(0, firstspace-1)
    end
    awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end
-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end

-- {{{ Variable definitions
home          = os.getenv("HOME")
config        = awful.util.getdir("config")
themes        = config .. "/themes"
themename     = "zenburn-alin"
themedir      = themes .. "/" .. themename

-- Themes define colours, icons, font and wallpapers.
beautiful.init(themedir .. "/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Optional variables used for the desktop menu
browser       = "firefox"
chat          = "skype"
mail          = "thunderbird"
clementine    = "clementine"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
altkey = "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    --awful.layout.suit.tile.left,
    --awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier
}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end

-- {{{ Function definitions
-- If you can't seem switch to a Java window using your keyboard:
function delay_raise()
    -- 5 ms ages in computer time, unnoticeable
    local raise_timer = timer { timeout = 0.005 }
    raise_timer:connect_signal("timeout", function()
        if client.focus then
            client.focus:raise()
        end
        raise_timer:stop()
    end)
    raise_timer:start()
end

-- scan directory, and optionally filter outputs
function randomize_lista(a)
    return a[math.random(#a)]
end

function scandir(directory, filter)
    local i, t, popen = 0, {}, io.popen
    if not filter then
        filter = function(s) return true end
    end
    print(filter)
    for filename in popen('ls -a  "'..directory..'"'):lines() do
        if filter(filename) then
            i = i + 1
            t[i] = filename
        end
    end
    return t
end

wp_index = 1
wp_timeout  = 600
wp_path = home .. "/Wallpapers/"
wp_filter = function(s) return string.match(s,"%.png$") or string.match(s,"%.jpg$") or string.match(s,"%.jpeg$") end
wp_files = scandir(wp_path, wp_filter)
-- setup the timer
wp_timer = timer { timeout = wp_timeout }
wp_timer:connect_signal("timeout", function()
  -- set wallpaper to current index for all screens
  for s = 1, screen.count() do
    -- get next random index
    wp_index = math.random( 1, #wp_files)
    gears.wallpaper.maximized(wp_path .. wp_files[wp_index], s, true)
  end
  -- stop the timer (we don't need multiple instances running at the same time)
  wp_timer:stop()
  --restart the timer
  wp_timer.timeout = wp_timeout
  wp_timer:start()
end)

-- initial start when rc.lua is first run
wp_timer:start()

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ " ☠ ", " ⌥ ", " ✇ ", " ⍜ ", " ✣ ", " ⌨ ", " ⌘ ", " ☕ " }, s, layouts[1])
end

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}
appsmenu = {
    { "terminal", terminal },
    { "browser", browser },
    { "mail", mail },
    { "chat", skype },
    { "melody", clementine },
}
mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "apps", appsmenu, beautiful.awesome_icon },

                                    { "terminal", terminal },
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-- {{{ Calendar
local blingbling = require("blingbling")
my_cal=blingbling.calendar.new({type = "imagebox", image = beautiful.calendar_icon})

-- {{{ Clock
--mytextclock = awful.widget.textclock("%a %b %d, %H:%M:%S", 1)
mytextclockicon = wibox.widget.imagebox()
mytextclockicon:set_image(beautiful.widget_clock)

-- {{{ Kernel Info
sysicon = wibox.widget.imagebox()
sysicon:set_image(beautiful.widget_sys)
syswidget = wibox.widget.textbox()
vicious.register( syswidget, vicious.widgets.os, "<span color=\"#66ff33\">$2</span>")

-- {{{ Uptime
uptimeicon = wibox.widget.imagebox()
uptimeicon:set_image(beautiful.widget_uptime)
uptimewidget = wibox.widget.textbox()
vicious.register( uptimewidget, vicious.widgets.uptime, "<span color=\"#66ff33\">$2.$3'</span>")

-- {{{ Temp
tempicon = wibox.widget.imagebox()
tempicon:set_image(beautiful.widget_temp)
tempicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("" .. terminal .. "-e powertop", false) end)
))
tempwidget = wibox.widget.textbox()
vicious.register(tempwidget, vicious.widgets.thermal, "<span color=\"#66ff33\">°C</span>", 9, { "coretemp.0", "core"} )

local function disptemp()
    local f, infos
    local capi = {
    mouse = mouse,
        screen = screen
    }

    f = io.popen("sensors && hddtemp /dev/sda")
    infos = f:read("*all")
    f:close()

    showtempinfo = naughty.notify( {
        text	= infos,
        timeout	= 0,
        position = "bottom_right",
        margin = 10,
        height = 230,
        width = 405,
        border_color = '#404040',
        border_width = 1,
        -- opacity = 0.95,
        screen	= capi.mouse.screen })
end

tempwidget:connect_signal('mouse::enter', function () disptemp(path) end)
tempwidget:connect_signal('mouse::leave', function () naughty.destroy(showtempinfo) end)

-- {{{ Volume
volicon = wibox.widget.imagebox()
volicon:set_image(beautiful.widget_vol)
volumewidget = wibox.widget.textbox()
vicious.register( volumewidget, vicious.widgets.volume, "<span color=\"#66ff33\">$1%</span>", 1, "Master" )
volumewidget:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("amixer -q sset Master toggle", false) end),
    awful.button({ }, 3, function () awful.util.spawn("" .. terminal .. " -e alsamixer", true) end),
    awful.button({ }, 4, function () awful.util.spawn("amixer -q sset Master 1dB+", false) end),
    awful.button({ }, 5, function () awful.util.spawn("amixer -q sset Master 1dB-", false) end)
))

-- {{{ Cpu
cpuicon = wibox.widget.imagebox()
cpuicon:set_image(beautiful.widget_cpu)
cpuwidget = wibox.widget.textbox()
vicious.register( cpuwidget, vicious.widgets.cpu, "<span color=\"#66ff33\">$1%</span>", 3)
cpuicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("" .. terminal .. " -e saidar -c", false) end)
))

-- {{{ Ram
memicon = wibox.widget.imagebox()
memicon:set_image(beautiful.widget_mem)
memwidget = wibox.widget.textbox()
vicious.register(memwidget, vicious.widgets.mem, "<span color=\"#66ff33\">$2 MB</span>", 1)
memicon:buttons(awful.util.table.join(
    awful.button({ }, 1, function () awful.util.spawn("" .. terminal .. " -e htop", false) end)
))

-- {{{ Hard Drives
fsicon = wibox.widget.imagebox()
fsicon:set_image(beautiful.widget_fs)
-- vicious.cache(vicious.widgets.fs)
fswidget = wibox.widget.textbox()
vicious.register(fswidget, vicious.widgets.fs, "<span color=\"#66ff33\">${/ used_p}%</span>", 10)

local function dispdisk()
    local f, infos
    local capi = {
        mouse = mouse,
        screen = screen
    }

    f = io.popen("dfc -d | grep /dev/sda")
    infos = f:read("*all")
    f:close()

    showdiskinfo = naughty.notify( {
        text	= infos,
        timeout	= 0,
        position = "top_right",
        margin = 10,
        height = 77,
        width = 620,
        border_color = '#404040',
        border_width = 1,
        -- opacity = 0.95,
        screen	= capi.mouse.screen })
end

fswidget:connect_signal('mouse::enter', function () dispdisk(path) end)
fswidget:connect_signal('mouse::leave', function () naughty.destroy(showdiskinfo) end)

-- {{{ Spacers
rbracket = wibox.widget.textbox()
rbracket:set_text(']')
lbracket = wibox.widget.textbox()
lbracket:set_text('[')
line = wibox.widget.textbox()
line:set_text('|')
space = wibox.widget.textbox()
space:set_text(' ')

-- {{{ Layout
-- Create a wibox for each screen and add it
mywibox = {}
mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              delay_raise()
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              delay_raise()
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()

    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                            awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                            awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                            awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, border_width = 0, height = 20 })

    -- Widgets that are aligned to the left
    left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mytaglist[s])
    left_layout:add(space)
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(space)
    right_layout:add(space)
    right_layout:add(memicon)
    right_layout:add(memwidget)
    right_layout:add(space)
    right_layout:add(space)
    right_layout:add(cpuicon)
    right_layout:add(cpuwidget)
    right_layout:add(space)
    right_layout:add(space)
    right_layout:add(volicon)
    right_layout:add(volumewidget)
    right_layout:add(space)
    right_layout:add(space)
    right_layout:add(tempicon)
    right_layout:add(tempwidget)
    right_layout:add(space)
    right_layout:add(space)
    right_layout:add(uptimeicon)
    right_layout:add(uptimewidget)
    right_layout:add(space)
    right_layout:add(fsicon)
    right_layout:add(fswidget)
    right_layout:add(space)
    right_layout:add(space)
    right_layout:add(sysicon)
    right_layout:add(syswidget)
    right_layout:add(space)
    right_layout:add(space)
    right_layout:add(mytextclockicon)
    --right_layout:add(mytextclock)
    right_layout:add(my_cal)
    right_layout:add(space)

    -- Now bring it all together
    layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)

    -- Create the bottom wibox
    mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, border_width = 0, height = 20 })
    mybottomwibox[s].visible = false

    -- Widgets that are aligned to the left
    bottom_left_layout = wibox.layout.fixed.horizontal()
    bottom_left_layout:add(space) 

    -- Widgets that are aligned to the right
    bottom_right_layout = wibox.layout.fixed.horizontal()
    bottom_right_layout:add(space) 
    if s == 1 then bottom_right_layout:add(wibox.widget.systray()) end
    bottom_right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    bottom_layout = wibox.layout.align.horizontal()
    bottom_layout:set_left(bottom_left_layout)
    bottom_layout:set_middle(mytasklist[s])
    bottom_layout:set_right(bottom_right_layout)
    mybottomwibox[s]:set_widget(bottom_layout)

end

-- {{{ Mouse Bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

-- {{{ Key Bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey, "Control" }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey, "Control" }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Left",
        function ()
            awful.client.focus.byidx(-1)
            delay_raise()
        end),
    awful.key({ modkey,           }, "Right",
        function ()
            awful.client.focus.byidx(1)
            delay_raise()
        end),

    -- Show/Hide Wibox
    awful.key({ modkey }, "b", function ()
    mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible end),
    awful.key({ modkey, altkey }, "b", function ()
    mybottomwibox[mouse.screen].visible = not mybottomwibox[mouse.screen].visible end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),
    -- Layout manipulation
    awful.key({ altkey,        }, "Left", function () awful.client.swap.byidx(  1)    end),
    awful.key({ altkey,        }, "Right", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, altkey }, "Left", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, altkey }, "Right", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            delay_raise()
        end),


    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    -- Volume control
    awful.key({}, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -q sset Master 1dB+") end),
    awful.key({}, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -q sset Master 1dB-") end),


    -- Take A Screenshot
    awful.key({ }, "Print", function () awful.util.spawn( "scrot", false ) end),

    awful.key({ modkey,        }, "x",      function () awful.util.spawn( "slock", false ) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift" }, "q", awesome.quit),

    -- Prompt
    awful.key({ modkey }, "r",      function () mypromptbox[mouse.screen]:run() end),
    awful.key({ modkey, "Control" }, ",", awful.client.restore)
)

clientkeys = awful.util.table.join(
    awful.key({ altkey            }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey,           }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, ",",      function (c) c.minimized = not c.minimized    end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end),
    awful.key({ modkey,           }, "j",
        function (c)
            c.maximized_vertical   = not c.maximized_vertical
        end),
    awful.key({ modkey         }, "k",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = true,
                     keys = clientkeys,
                     maximized_vertical = false,
                     maximized_horizontal = false,
                     buttons = clientbuttons,
                     size_hints_honor = false
                    }
   },
}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
