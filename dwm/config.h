/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 5;        /* gap pixel between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "Lilex Nerd Font:size=10" };
static const char dmenufont[]       = "Lilex Nerd Font:size=10";
static const char *brightnessup[]   = { "brightnessctl", "set", "+5%", NULL };
static const char *brightnessdown[] = { "brightnessctl", "set", "5%-", NULL };

static const char *volumeup[]       = { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "+5%", NULL };
static const char *volumedown[]     = { "pactl", "set-sink-volume", "@DEFAULT_SINK@", "-5%", NULL };
static const char *volumemute[]     = { "pactl", "set-sink-mute", "@DEFAULT_SINK@", "toggle", NULL };

static const char *screenshot[] = {
    "/bin/sh",
    "-c",
    "mkdir -p \"$HOME/Pictures/Screenshots\" && "
    "maim -s \"$HOME/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png\"",
    NULL
};
static const char normbgcolor[]     = "#131818";
static const char normbordercolor[] = "#708081";
static const char normfgcolor[]     = "#c7ccca";
/* Selected (focused) */
static const char selfgcolor[]      = "#ffffff";
static const char selbordercolor[]  = "#649BC2";
static const char selbgcolor[]      = "#BB8937";
static const char *colors[][3] = {
       /*               fg           bg           border   */
       [SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
       [SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
};/* tagging */
static const char *tags[] = { "one", "two", "three", "four", "five" };

static const Rule rules[] = {
	{ NULL, NULL, NULL, 0, 0, -1 },
};

/* layout(s) */
static const float mfact     = 0.5; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */
static const int refreshrate = 60;  /* refresh rate (per second) for client move/resize */

static const Layout layouts[] = {
	/* symbol     arrange function */
    { ">",      NULL },    /* no layout function means floating behavior */
	{ "[]=",      tile },    /* first entry is default */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-fn", dmenufont, "-nb", normbgcolor, "-nf", normfgcolor, "-sb", selbordercolor, "-sf", selfgcolor, NULL };
static const char *termcmd[]  = { "kitty", NULL };

static const Key keys[] = {
	/* launcher / terminal */
	{ MODKEY,                   XK_d,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                   XK_Return, spawn,          {.v = termcmd } },

	/* window focus */
	{ MODKEY,                   XK_Down,   focusstack,     {.i = +1 } },
	{ MODKEY,                   XK_Up,     focusstack,     {.i = -1 } },
	{ MODKEY,                   XK_Tab,    view,           {.ui = ~0 } },

	/* master area */
	{ MODKEY,                   XK_Left,   setmfact,       {.f = -0.05 } },
	{ MODKEY,                   XK_Right,  setmfact,       {.f = +0.05 } },
	{ MODKEY,                   XK_Page_Down, incnmaster, {.i = +1 } },
	{ MODKEY,                   XK_Page_Up,   incnmaster, {.i = -1 } },

	/* layouts */
	{ MODKEY,                   XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                   XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                   XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                   XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,         XK_space,  togglefloating, {0} },

	/* window management */
	{ MODKEY|ShiftMask,         XK_c,      killclient,     {0} },

    /* brightness */
    { 0, XF86XK_MonBrightnessUp,   spawn, {.v = brightnessup } },
    { 0, XF86XK_MonBrightnessDown, spawn, {.v = brightnessdown } },

    /* volume */
    { 0, XF86XK_AudioRaiseVolume, spawn, {.v = volumeup } },
    { 0, XF86XK_AudioLowerVolume, spawn, {.v = volumedown } },
    { 0, XF86XK_AudioMute,        spawn, {.v = volumemute } },

    /* screenshot */
    { 0, XK_Print,                spawn, {.v = screenshot } },

	/* workspaces */
	TAGKEYS(XK_1, 0)
	TAGKEYS(XK_2, 1)
	TAGKEYS(XK_3, 2)
	TAGKEYS(XK_4, 3)
	TAGKEYS(XK_5, 4)

	/* quit */
	{ MODKEY|ShiftMask,         XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

