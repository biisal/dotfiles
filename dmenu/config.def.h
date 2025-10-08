/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1; /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {"JetBrainsMono Nerd Font:size=11"};
static const char *prompt =
    NULL; /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
    /*     fg         bg       */
    [SchemeNorm] =
        {"#C0C0C0",
         "#0A0A0A"}, // normal: light gray text on deep black background
    [SchemeSel] =
        {"#0A0A0A",
         "#888888"}, // selected: deep black text on muted gray selection
    [SchemeOut] =
        {"#0A0A0A",
         "#BBBBBB"}, // output: deep black text on light gray background
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
