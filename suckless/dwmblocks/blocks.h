// Modify this file to change what commands output to your statusbar, and
// recompile using the make command.
static const Block blocks[] = {
    /*Icon*/ /*Command*/ /*Update Interval*/ /*Update Signal*/
    {"", "~/suckless/dwmblocks/scripts/show-wireless-device.sh", 10, 0},
    {"",
     "free -h | awk '/^Mem/ {mem=$3\"/\"$2} /^Swap/ {swap=$3\"/\"$2} END "
     "{gsub(\"i\",\"\",mem); gsub(\"i\",\"\",swap); printf \"%s (%s)\\n\", "
     "mem, swap}'",
     5, 0},

    {"", "top -bn1 | grep 'Cpu(s)' | awk '{printf \"C: %d%%\", $2+$4}'", 10, 0},
    {"", "date '+%b %d (%a)   %I:%M%p' | tr '[:lower:]' '[:upper:]'", 2, 0},
    // battery status
    {"", "~/suckless/go-scripts/battery-status/battery_status", 35, 5},
    {"   ", "pw-volume status | jq .percentage", 0, 6},
};

// sets delimiter between status commands. NULL character ('\0') means no
// delimiter.
static char delim[] = "   ";
static unsigned int delimLen = sizeof(delim) - 1;
