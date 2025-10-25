// somebar - dwl bar
// See LICENSE file for copyright and license details.

#pragma once
#include "common.hpp"

constexpr bool topbar = true;

constexpr int paddingX = 10;
constexpr int paddingY = 2;

// See https://docs.gtk.org/Pango/type_func.FontDescription.from_string.html
constexpr const char *font = "JetBrainsMono Nerd Font Medium 12";

constexpr ColorScheme colorInactive = {Color(0x85, 0x86, 0x8f),
                                       Color(0x16, 0x17, 0x20)};

constexpr ColorScheme colorActive = {Color(0xE0, 0xF2, 0xFF),
                                     Color(0x16, 0x17, 0x20)};

constexpr const char *termcmd[] = {"kitty", nullptr};

static std::vector<std::string> tagNames = {
    "󰣇", "󰈹", "󰑋", "4", "5", "6", "7", "8", "9",
};

constexpr Button buttons[] = {
    {ClkStatusText, BTN_RIGHT, spawn, {.v = termcmd}},
};
