
--
-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- shifty - dynamic tagging library
require("shifty")
--PMi--naughty.config.presets.position = "bottom_right"
--PMi--naughty.config.default_preset.position         = "bottom_right"

-- useful for debugging, marks the beginning of rc.lua exec
print("Entered rc.lua: " .. os.time())
-- Pugin/Widgets
--PMi--require("revelation") 
--PMi--require("debian.menu")
-- no spaces between windows
--PMi--size_hints_honor = false
-- Variable definitions
-- Themes define colours, icons, and wallpapers
-- The default is a dark theme
theme_path = "/usr/share/awesome/themes/sky/theme.lua"
theme_path = "/usr/share/awesome/themes/default/theme.lua"
theme_path = "/usr/share/awesome/themes/zenburn/theme.lua"
-- Uncommment this for a lighter theme
-- theme_path = "/usr/share/awesome/themes/sky/theme"

-- Actually load theme
beautiful.init(theme_path)

-- This is used later as the default terminal and editor to run.
browser = "firefox"
mail = "thunderbird"
terminal = "roxterm"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
wibox_pos = "top"


--#powerline
--repository_root = "" #https://github.com/Lokaltog/powerline
--package.path = package.path .. ';{repository_root}/powerline/bindings/awesome/?.lua'
--require('powerline')
--right_layout:add(powerline_widget)



if os.hostname == "bluepanic" then
	mail = "ibm-notes8"
	wibox_pos = "bottom"
end
if os.hostname == "dontpanic-vm" then
	wibox_pos = "bottom"
end

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key, I suggest you to remap
-- Mod4 to another key using xmodmap or other tools.  However, you can use
-- another modifier like Mod1, but it may interact with others.
--modkey = "Mod1" - Alt
--modkey = "Mod4" - WinLogo
modkey = os.getenv("MODKEY") or "Mod1"

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
--    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
--    awful.layout.suit.tile.bottom,
--    awful.layout.suit.tile.top,
--    awful.layout.suit.fair,
--    awful.layout.suit.fair.horizontal,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
--    awful.layout.suit.magnifier,
    awful.layout.suit.floating,
    awful.layout.suit.spiral
}

-- Define if we want to use titlebar on all applications.
use_titlebar = false

-- terminal,2,3,web,mail,workspace,media,7,office
-- Shifty configured tags.
shifty.config.tags = {
    sys = {
		layout   = awful.layout.suit.spiral,
        mwfact    = 0.65,
        exclusive = false,
        position  = 1,
        init      = true,
        screen    = 1,
        slave     = true,
    },
    www = {
        layout      = awful.layout.suit.max,
        mwfact      = 0.75,
        exclusive   = true,
        position    = 3,
        spawn       = browser,
    },
    mail = {
        layout    = awful.layout.suit.max,
        mwfact    = 0.55,
        exclusive = false,
        position  = 4,
        slave     = false,
	spawn	  = mail,
    },
    virtuals = {
        layout    = awful.layout.suit.max.fullscreen,
        exclusive = false,
        position  = 2,
        slave     = true,
	screen 	  = 1,
        max_clients = 1,
    },
    media = {
        layout    = awful.layout.suit.float,
        exclusive = true,
        position  = 7,
		screen = 2,
    },
    workspace = {
        layout    = awful.layout.suit.max,
        mwfact    = 0.60,
        exclusive = false,
        position  = 8,
        init      = false,
        slave     = true,
        max_clients = 3,
    },
    terminal = {
        layout    = awful.layout.suit.tile,
        mwfact    = 0.60,
        exclusive = false,
        position  = 9,
        init      = false,
        slave     = false,
        max_clients = 3,
	spawn 	= terminal,
    },
    office = {
        layout   = awful.layout.suit.max,
        position = 5,
		screen= 2,
		spawn = "/opt/openoffice4/program/soffice",
    },
    tv = {
        layout   = awful.layout.suit.max.fullscreen,
        max_clients = 1,
		screen = 2,
    },
    remote = {
		position = 6,
        layout   = awful.layout.suit.max,
		screen = 2,
        spawn       = "remmina",
    },
}

-- SHIFTY: application matching rules
-- order here matters, early rules will be applied first
shifty.config.apps = {
    {
        match = {
            "roxterm",
            "gnome-terminal",
            "xterm",
            "rxvt",
        },
        tag = "terminal",
    },
    {
        match = {
            "Navigator",
            "Vimperator",
            "Firefox",
            "Chrome",
            "Gran Paradiso",
        },
        tag = "www",
    },
    {
        match = {
            "Shredder.*",
            "Thunderbird",
            "mutt",
	    "Lotus Notes",
	    "NotesLogo",
            "IBM Lotus Notes",
        },
        tag = "mail",
    },
    {
        match = {
	    "vmplayer",
	    "Qt-subapplication",
	    "VirtualBox",
	    "virtualbox",
	    "virt-manager",
	    "Virt-manager",
        },
        tag = "virtuals",
        --nopopup = true,	-- do not skip there
    },
    {
        match = {
            "pcmanfm",
        },
        slave = true
    },
    {
        match = {
            "OpenOffice.*",
            "Abiword",
            "Gnumeric",
            "Libreoffice",
			"libreoffice-calc",
			"libreoffice-word",
			"libreoffice-presentation",
			"VCLSalFrame.DocumentWindow",
            --"*Symphony*",
	    --"IBM Lotus Symphony",
        },
        tag = "office",
    },
    {
        match = {
            "gimp",
            "bibble5",
            "aftershot",
            "audacious",
            "Ufraw",
            "eclipse",
	    "inkscape",
	    "Acroread",
	    "Miro",
	     "Hugin",
		"qtpfsgui",
		"Picasa3.exe",
		"Bibble 5 Pro",
		"Bibble5",
        },
        tag = "workspace",
        nopopup = true,
    },
    {
        match = {
            "Mplayer.*",
            "SMplayer.*",
            "Smplayer",
            "Mirage",
            "Amarok",
            "Amarok",
            "Songbird",
            "Anki",
            "gtkpod",
            "easytag",
            "pidgin",
        },
        tag = "media",
        nopopup = true,
    },
    {
        match = {
            "MPlayer",
            "Gnuplot",
            "galculator",
        },
        float = true,
    },
    {	
	match = {
		"remmina",
		"Remmina",
		"rdesktop",
		"grdesktop",
	},	
 	tag = "remote",
    },
    { 
	match = { 
		"kaffeine",
	  },
	tag = "tv",
    },
    {
        match = {
            terminal,
        },
        honorsizehints = false,
        slave = true,
    },
    {
        match = {""},
        buttons = awful.util.table.join(
            awful.button({}, 1, function (c) client.focus = c; c:raise() end),
            awful.button({modkey}, 1, function(c)
                client.focus = c
                c:raise()
                awful.mouse.client.move(c)
                end),
            awful.button({modkey}, 3, awful.mouse.client.resize)
            )
    },
}

-- SHIFTY: default tag creation rules
-- parameter description
--  * floatBars : if floating clients should always have a titlebar
--  * guess_name : should shifty try and guess tag names when creating
--                 new (unconfigured) tags?
--  * guess_position: as above, but for position parameter
--  * run : function to exec when shifty creates a new tag
--  * all other parameters (e.g. layout, mwfact) follow awesome's tag API
shifty.config.defaults = {
    layout = awful.layout.suit.tile.bottom,
    ncol = 1,
    mwfact = 0.60,
    floatBars = true,
    guess_name = true,
    guess_position = true,
}

--  Wibox
-- Create a textbox widget
mytextclock = awful.widget.textclock({align = "right"})

-- Create a laucher widget and a main menu
myawesomemenu = {
    {"manual", terminal .. " -e man awesome"},
    {"edit config",
     editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua"},
    {"restart", awesome.restart},
    {"quit", awesome.quit}
}

mymainmenu = awful.menu(
    {
        items = {
            {"awesome", myawesomemenu, beautiful.awesome_icon},
              {"open terminal", terminal},
              {"open web", "firefox"},
              {"open mail", "thunderbird"},
              {"open carte", "appscarte"},
              {"screenshot", "scrot -s"}}
          })

mylauncher = awful.widget.launcher({image = image(beautiful.awesome_icon),
                                     menu = mymainmenu})

-- Create a systray
mysystray = widget({type = "systray", align = "right"})

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
    awful.button({}, 1, awful.tag.viewonly),
    awful.button({modkey}, 1, awful.client.movetotag),
    awful.button({}, 3, function(tag) tag.selected = not tag.selected end),
    awful.button({modkey}, 3, awful.client.toggletag),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
    )

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
    awful.button({}, 1, function(c)
        if not c:isvisible() then
            awful.tag.viewonly(c:tags()[1])
        end
        client.focus = c
        c:raise()
        end),
    awful.button({}, 3, function()
        if instance then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({width=250})
        end
        end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end
        end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
        end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] =
        awful.widget.prompt({layout = awful.widget.layout.leftright})
    -- Create an imagebox widget which will contains an icon indicating which
    -- layout we're using.  We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
            awful.button({}, 1, function() awful.layout.inc(layouts, 1) end),
            awful.button({}, 3, function() awful.layout.inc(layouts, -1) end),
            awful.button({}, 4, function() awful.layout.inc(layouts, 1) end),
            awful.button({}, 5, function() awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist.new(s,
                                            awful.widget.taglist.label.all,
                                            mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist.new(function(c)
                        return awful.widget.tasklist.label.currenttags(c, s)
                    end,
                                              mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({position = wibox_pos, screen = s})
    -- Add widgets to the wibox - order matters
    mywibox[s].widgets = {
        {
            mylauncher,
            mytaglist[s],
            mypromptbox[s],
            layout = awful.widget.layout.horizontal.leftright
        },
        mylayoutbox[s],
        mytextclock,
        s == 1 and mysystray or nil,
        mytasklist[s],
        layout = awful.widget.layout.horizontal.rightleft
        }

    mywibox[s].screen = s
end

-- SHIFTY: initialize shifty
-- the assignment of shifty.taglist must always be after its actually
-- initialized with awful.widget.taglist.new()
shifty.taglist = mytaglist
shifty.init()

-- Mouse bindings
root.buttons({
    awful.button({}, 3, function() mymainmenu:toggle() end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)
})

-- Key bindings
globalkeys = awful.util.table.join(
    -- Tags
    awful.key({modkey,}, "Left", awful.tag.viewprev),
    awful.key({modkey,}, "Right", awful.tag.viewnext),
    awful.key({modkey,}, "Escape", awful.tag.history.restore),

    -- Shifty: keybindings specific to shifty
    awful.key({modkey, "Shift"}, "d", shifty.del), -- delete a tag
    awful.key({modkey, "Shift"}, "n", shifty.send_prev), -- client to prev tag
    awful.key({modkey}, "n", shifty.send_next), -- client to next tag
    awful.key({modkey, "Control"}, "n", function()
        shifty.tagtoscr(awful.util.cycle(screen.count(), mouse.screen + 1))
    end), -- move client to next tag
    awful.key({modkey}, "a", shifty.add), -- creat a new tag
    awful.key({modkey,}, "r", shifty.rename), -- rename a tag
    awful.key({modkey, "Shift"}, "a", -- nopopup new tag
    function()
        shifty.add({nopopup = true})
    end),

    awful.key({modkey,}, "j",
    function()
        awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({modkey,}, "k",
    function()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
    end),
    awful.key({modkey,}, "w", function() mymainmenu:show(true) end),

    -- Layout manipulation
    awful.key({modkey, "Shift"}, "j",
        function() awful.client.swap.byidx(1) end),
    awful.key({modkey, "Shift"}, "k",
        function() awful.client.swap.byidx(-1) end),
    awful.key({modkey, "Control"}, "j", function() awful.screen.focus(1) end),
    awful.key({modkey, "Control"}, "k", function() awful.screen.focus(-1) end),
    awful.key({modkey,}, "u", awful.client.urgent.jumpto),
    awful.key({modkey,}, "Tab",
    function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:raise()
        end
    end),

    --PMi FIX-- Prompt
    awful.key({ modkey },            "x",     function () mypromptbox[mouse.screen]:run() end),

    -- Standard program
    awful.key({modkey,}, "Return", function() awful.util.spawn(terminal) end),
    awful.key({modkey, "Control"}, "r", awesome.restart),
    awful.key({modkey, "Shift"}, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    --awful.key({modkey,}, "l", function() awful.tag.incmwfact(0.05) end),
    --awful.key({modkey,}, "h", function() awful.tag.incmwfact(-0.05) end),
    --awful.key({modkey, "Shift"}, "h", function() awful.tag.incnmaster(1) end),
    --awful.key({modkey, "Shift"}, "l", function() awful.tag.incnmaster(-1) end),
    --awful.key({modkey, "Control"}, "h", function() awful.tag.incncol(1) end),
    --awful.key({modkey, "Control"}, "l", function() awful.tag.incncol(-1) end),
    --awful.key({modkey,}, "space", function() awful.layout.inc(layouts, 1) end),
    --awful.key({modkey, "Shift"}, "space",
        --function() awful.layout.inc(layouts, -1) end),

    --Prompt
    awful.key({modkey}, "F1", function()
        awful.prompt.run({prompt = "Run: "},
        mypromptbox[mouse.screen],
        awful.util.spawn, awful.completion.shell,
        awful.util.getdir("cache") .. "/history")
        end),

    awful.key({modkey}, "F4", function()
        awful.prompt.run({prompt = "Run Lua code: "},
        mypromptbox[mouse.screen],
        awful.util.eval, nil,
        awful.util.getdir("cache") .. "/history_eval")
        end)
    )

-- Client awful tagging: this is useful to tag some clients and then do stuff
-- like move to tag on them
clientkeys = awful.util.table.join(
    awful.key({modkey,}, "f", function(c) c.fullscreen = not c.fullscreen  end),
    awful.key({modkey, "Shift"}, "c", function(c) c:kill() end),
    awful.key({modkey, "Control"}, "space", awful.client.floating.toggle),
    awful.key({modkey, "Control"}, "Return",
        function(c) c:swap(awful.client.getmaster()) end),
    awful.key({modkey,}, "o", awful.client.movetoscreen),
    awful.key({modkey, "Shift"}, "r", function(c) c:redraw() end),
    awful.key({modkey}, "t", awful.client.togglemarked),
    awful.key({modkey,}, "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

--clientkeys = awful.util.table.join(
--{
    --awful.key({modkey,}, "f", function(c) c.fullscreen = not c.fullscreen  end),
    --awful.key({modkey, "Shift"}, "c", function(c) c:kill() end),
    --awful.key({modkey, "Control"}, "space", awful.client.floating.toggle),
    --awful.key({modkey, "Control"}, "Return",
        --function(c) c:swap(awful.client.getmaster()) end),
    --awful.key({modkey,}, "o", awful.client.movetoscreen),
    --awful.key({modkey, "Shift"}, "r", function(c) c:redraw() end),
    --awful.key({modkey}, "t", awful.client.togglemarked),
    --awful.key({modkey,}, "m",
        --function(c)
            --c.maximized_horizontal = not c.maximized_horizontal
            --c.maximized_vertical   = not c.maximized_vertical
        --end),
--})
-- SHIFTY: assign client keys to shifty for use in
-- match() function(manage hook)
shifty.config.clientkeys = clientkeys
shifty.config.modkey = modkey

-- Compute the maximum number of digit we need, limited to 9
for i = 1, (shifty.config.maxtags or 9) do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({modkey}, i, function()
            local t =  awful.tag.viewonly(shifty.getpos(i))
            end),
        awful.key({modkey, "Control"}, i, function()
            local t = shifty.getpos(i)
            t.selected = not t.selected
            end),
        awful.key({modkey, "Control", "Shift"}, i, function()
            if client.focus then
                awful.client.toggletag(shifty.getpos(i))
            end
            end),
        -- move clients to other tags
        awful.key({modkey, "Shift"}, i, function()
            if client.focus then
                t = shifty.getpos(i)
                awful.client.movetotag(t)
                awful.tag.viewonly(t)
            end
        end))
    end

-- Set keys
root.keys(globalkeys)

-- Hook function to execute when focusing a client.
client.add_signal("focus", function(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_focus
    end
end)

-- Hook function to execute when unfocusing a client.
client.add_signal("unfocus", function(c)
    if not awful.client.ismarked(c) then
        c.border_color = beautiful.border_normal
    end
end)
