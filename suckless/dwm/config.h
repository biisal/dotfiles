/* See LICENSE file for copyright and license details. */
#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx = 3; /* border pixel of windows */
static const unsigned int snap = 32;    /* snap pixel */
static const unsigned int gappih = 0;   /* horiz inner gap between windows */
static const unsigned int gappiv = 0;   /* vert inner gap between windows */
static const unsigned int gappoh =
    10; /* horiz outer gap between windows and screen edge */
static const unsigned int gappov =
    30; /* vert outer gap between windows and screen edge */
static int smartgaps =
    0; /* 1 means no outer gap when there is only one window */
static const int showbar = 1; /* 0 means no bar */
static const int topbar = 1;  /* 0 means bottom bar */

static const char *fonts[] = {"JetBrainsMono Nerd Font:style=Medium:size=12",
                              "JetBrainsMono Nerd Font:size=12",
                              "Noto Color Emoji:size=12"};
static const char dmenufont[] = "JetBrainsMono Nerd Font:style=Medium:size=12";

static const char col_bg[] = "#0e0e14"; // bg matches DWL
static const char col_fg_inactive[] = "#8e9199";
static const char col_fg_active[] = "#b6d0ea";

static const char col_border[] = "#111118";
static const char col_focus[] = "#4a6d9c";

static const char *colors[][3] = {
    [SchemeNorm] = {col_fg_inactive, col_bg, col_border},
    [SchemeSel] = {col_fg_active, col_bg, col_focus},
};
/* tagging */
static const char *tags[] = {
    "󰣇", "󰈹", " ", "4", "5", "6", "7", "8", "9",
};

static const Rule rules[] = {
    /* class      instance    title       tags mask     isfloating   monitor */
    {"Gimp", NULL, NULL, 0, 1, -1},
    {"Firefox", NULL, NULL, 1 << 1, 0, -1}, /* DWL: tag 2 (1 << 1) */
};

/* layout(s) */
static const float mfact = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;    /* number of clients in master area */
static const int resizehints =
    1; /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen =
    0; /* 1 will force focus on the fullscreen window */
static const int refreshrate =
    120; /* refresh rate (per second) for client move/resize */

#define FORCE_VSPLIT                                                           \
  1 /* nrowgrid layout: force two clients to always split vertically */
#include "vanitygaps.c"

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"[]=", tile}, /* first entry is default */
    {"><>", NULL}, /* no layout function means floating behavior - DWL style
                      order */
    {"[M]", monocle},
    {"[@]", spiral},
    {"[\\]", dwindle},
    {"H[]", deck},
    {"TTT", bstack},
    {"===", bstackhoriz},
    {"HHH", grid},
    {"###", nrowgrid},
    {"---", horizgrid},
    {":::", gaplessgrid},
    {"|M|", centeredmaster},
    {">M>", centeredfloatingmaster},
    {NULL, NULL},
};

/* key definitions */
#define MODKEY Mod1Mask

/* DWL-style TAGKEYS: Ctrl for view, Ctrl+Shift for tag, Ctrl+Alt for
 * toggleview/toggletag */
#define TAGKEYS(KEY, TAG)                                                      \
  {ControlMask, KEY, view, {.ui = 1 << TAG}},                                  \
      {ControlMask | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                   \
      {ControlMask | MODKEY, KEY, toggleview, {.ui = 1 << TAG}}, {             \
    ControlMask | MODKEY | ShiftMask, KEY, toggletag, { .ui = 1 << TAG }       \
  }

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
  {                                                                            \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                       \
  }

/* commands */
static char dmenumon[2] = "0";
static const char *dmenucmd[] = {
    "j4-dmenu-desktop", "--dmenu=dmenu -i -p Run:", "--term=kitty", NULL};
static const char *webapopencmd[] = {
    "/home/avisek/.scripts/single-webapp-dmenu.sh", NULL};
static const char *clipboardcmd[] = {
    "sh", "-c", "clipmenu | xargs -r -0 xdotool key --clearmodifiers Return",
    NULL};
static const char *braveDuckduckSearchNewWindow[] = {
    "/home/avisek/.scripts/search-query.sh", "duckduckgo", "true", NULL};
static const char *braveYoutubeSearch[] = {
    "/home/avisek/.scripts/search-query.sh", "youtube", NULL};
static const char *braveYoutubeSearchNewWindow[] = {
    "/home/avisek/.scripts/search-query.sh", "youtube", "true", NULL};
static const char *termcmd[] = {"kitty", NULL};
static const char *brightup[] = {"brightnessctl", "set", "5%+", NULL};
static const char *brightdown[] = {"brightnessctl", "set", "5%-", NULL};
static const char *screenshotCmd[] = {
    "/home/avisek/.scripts/x-server/screenshot.sh", NULL};
static const char *cropScreenshotCmd[] = {
    "/home/avisek/.scripts/x-server/screenshot.sh", "crop", NULL};

static const Key keys[] = {
    /* modifier                     key        function        argument */

    /* === DWL-STYLE MAIN BINDINGS === */
    {MODKEY, XK_space, spawn, {.v = dmenucmd}}, /* DWL: Alt+Space = launcher */
    {MODKEY, XK_Return, spawn, {.v = termcmd}}, /* DWL: Alt+Return = terminal */
    {MODKEY,
     XK_w,
     spawn,
     {.v = (const char *[]){"brave", NULL}}},   /* DWL: Alt+w = browser */
    {MODKEY, XK_c, spawn, {.v = clipboardcmd}}, /* DWL: Alt+c = clipboard */

    /* Window management - DWL style */
    {MODKEY, XK_j, focusstack, {.i = +1}},  /* DWL: Alt+j = focus down */
    {MODKEY, XK_k, focusstack, {.i = -1}},  /* DWL: Alt+k = focus up */
    {MODKEY, XK_i, incnmaster, {.i = +1}},  /* DWL: Alt+i = increase master */
    {MODKEY, XK_d, incnmaster, {.i = -1}},  /* DWL: Alt+d = decrease master */
    {MODKEY, XK_h, setmfact, {.f = -0.05}}, /* DWL: Alt+h = shrink */
    {MODKEY, XK_l, setmfact, {.f = +0.05}}, /* DWL: Alt+l = expand */
    {MODKEY | ShiftMask,
     XK_Return,
     zoom,
     {0}},                       /* DWL: Alt+Shift+Return = zoom */
    {MODKEY, XK_Tab, view, {0}}, /* DWL: Alt+Tab = last tag */
    {MODKEY | ShiftMask, XK_c, killclient, {0}}, /* DWL: Alt+Shift+c = kill */

    /* Layout management - DWL style */
    {MODKEY, XK_t, setlayout, {.v = &layouts[0]}}, /* DWL: Alt+t = tile */
    {MODKEY, XK_f, setlayout, {.v = &layouts[1]}}, /* DWL: Alt+f = float */
    {MODKEY, XK_m, setlayout, {.v = &layouts[2]}}, /* DWL: Alt+m = monocle */
    {MODKEY, XK_r, setlayout, {0}}, /* DWL: Alt+r = reset layout */
    {MODKEY | ShiftMask,
     XK_space,
     togglefloating,
     {0}}, /* DWL: Alt+Shift+Space = toggle float */
    {MODKEY,
     XK_e,
     togglefloating,
     {0}}, /* DWL-inspired: Alt+e = toggle float */

    /* Monitor management - DWL style */
    {MODKEY,
     XK_comma,
     focusmon,
     {.i = -1}}, /* DWL: Alt+, = focus left monitor */
    {MODKEY,
     XK_period,
     focusmon,
     {.i = +1}}, /* DWL: Alt+. = focus right monitor */
    {MODKEY | ShiftMask,
     XK_comma,
     tagmon,
     {.i = -1}}, /* DWL: Alt+Shift+, = tag left monitor */
    {MODKEY | ShiftMask,
     XK_period,
     tagmon,
     {.i = +1}}, /* DWL: Alt+Shift+. = tag right monitor */

    /* View all tags - DWL style (Ctrl+0) */
    {ControlMask, XK_0, view, {.ui = ~0}},
    {MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},

    /* Exit - DWL style */
    {MODKEY | ShiftMask, XK_q, quit, {0}}, /* DWL: Alt+Shift+q = quit */

    /* === MEDIA KEYS === */
    {0, XK_Print, spawn, {.v = cropScreenshotCmd}},
    {ControlMask, XK_Print, spawn, {.v = screenshotCmd}},
    {0, XF86XK_MonBrightnessUp, spawn, {.v = brightup}},
    {0, XF86XK_MonBrightnessDown, spawn, {.v = brightdown}},
    {0, XF86XK_AudioRaiseVolume, spawn,
     SHCMD("/home/avisek/suckless/scripts/vol-up-down.sh up && pkill -RTMIN+6 "
           "dwmblocks")},
    {0, XF86XK_AudioLowerVolume, spawn,
     SHCMD("/home/avisek/suckless/scripts/vol-up-down.sh && pkill -RTMIN+6 "
           "dwmblocks")},
    {0, XF86XK_AudioMute, spawn,
     SHCMD("pw-volume mute toggle && pkill -RTMIN+6 dwmblocks")},

    /* === DWM-SPECIFIC FEATURES PRESERVED === */
    {MODKEY, XK_b, togglebar, {0}},
    {MODKEY | ShiftMask, XK_h, setcfact, {.f = +0.25}},
    {MODKEY | ShiftMask, XK_l, setcfact, {.f = -0.25}},
    {MODKEY | ShiftMask, XK_o, setcfact, {.f = 0.00}},

    /* Vanitygaps controls */
    {MODKEY | Mod4Mask, XK_u, incrgaps, {.i = +1}},
    {MODKEY | Mod4Mask | ShiftMask, XK_u, incrgaps, {.i = -1}},
    {MODKEY | Mod4Mask, XK_i, incrigaps, {.i = +1}},
    {MODKEY | Mod4Mask | ShiftMask, XK_i, incrigaps, {.i = -1}},
    {MODKEY | Mod4Mask, XK_o, incrogaps, {.i = +1}},
    {MODKEY | Mod4Mask | ShiftMask, XK_o, incrogaps, {.i = -1}},
    {MODKEY | Mod4Mask, XK_6, incrihgaps, {.i = +1}},
    {MODKEY | Mod4Mask | ShiftMask, XK_6, incrihgaps, {.i = -1}},
    {MODKEY | Mod4Mask, XK_7, incrivgaps, {.i = +1}},
    {MODKEY | Mod4Mask | ShiftMask, XK_7, incrivgaps, {.i = -1}},
    {MODKEY | Mod4Mask, XK_8, incrohgaps, {.i = +1}},
    {MODKEY | Mod4Mask | ShiftMask, XK_8, incrohgaps, {.i = -1}},
    {MODKEY | Mod4Mask, XK_9, incrovgaps, {.i = +1}},
    {MODKEY | Mod4Mask | ShiftMask, XK_9, incrovgaps, {.i = -1}},
    {MODKEY | Mod4Mask, XK_0, togglegaps, {0}},
    {MODKEY | Mod4Mask | ShiftMask, XK_0, defaultgaps, {0}},

    /* Your custom scripts */
    {MODKEY, XK_a, spawn, {.v = webapopencmd}},
    {MODKEY, XK_s, spawn, {.v = braveDuckduckSearchNewWindow}},
    {MODKEY, XK_y, spawn, {.v = braveYoutubeSearch}},
    {MODKEY | ShiftMask, XK_y, spawn, {.v = braveYoutubeSearchNewWindow}},
    {MODKEY,
     XK_p,
     spawn,
     {.v = (const char *[]){"rofimoji",
                            NULL}}}, /* moved from 'e' to avoid conflict */

    /* === TAG KEYS (DWL STYLE: Ctrl-based) === */
    TAGKEYS(XK_1, 0),
    TAGKEYS(XK_2, 1),
    TAGKEYS(XK_3, 2),
    TAGKEYS(XK_4, 3),
    TAGKEYS(XK_5, 4),
    TAGKEYS(XK_6, 5),
    TAGKEYS(XK_7, 6),
    TAGKEYS(XK_8, 7),
    TAGKEYS(XK_9, 8),
};

/* button definitions */
static const Button buttons[] = {
    /* click                event mask      button          function argument */
    {ClkLtSymbol, 0, Button1, setlayout, {0}},
    {ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button2, spawn, {.v = termcmd}},
    /* DWL-style: MODKEY + mouse buttons */
    {ClkClientWin, MODKEY, Button1, movemouse, {0}}, /* DWL: Alt+Left = move */
    {ClkClientWin,
     MODKEY,
     Button2,
     togglefloating,
     {0}}, /* DWL: Alt+Middle = toggle float */
    {ClkClientWin,
     MODKEY,
     Button3,
     resizemouse,
     {0}}, /* DWL: Alt+Right = resize */
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
};
