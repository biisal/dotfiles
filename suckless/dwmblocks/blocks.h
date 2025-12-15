// Modify this file to change what commands output to your statusbar, and
// recompile using the make command.
static const Block blocks[] = {
    /* Icon   Command     Interval   Signal */

    /* Wi-Fi */
    {"", "~/.scripts/show-wireless-device.sh", 40, 0},

    /* RAM - SWAP */
    {"",
     "free -h | awk '/^Mem/ {mem=$3} /^Swap/ {swap=$3} END "
     "{gsub(\"i\",\"\",mem); gsub(\"i\",\"\",swap); printf \"%s - %s\\n\", "
     "mem, swap}'",
     5, 0},

    /* CPU */
    {"", "top -bn1 | grep 'Cpu(s)' | awk '{printf \"%d%%\", $2+$4}'", 10, 0},

    /* Date */
    {"", "date '+%b %d (%a) | %I:%M%p' | tr '[:lower:]' '[:upper:]'", 2, 0},

    /* Battery */
    {"", "~/.scripts/battery-status.sh", 35, 5},

    /* Volume */
    {"  ", "pw-volume status | jq .percentage", 0, 6},
};

// sets delimiter between status commands. NULL character ('\0') means no
// delimiter.
static char delim[] = " | ";
static unsigned int delimLen = sizeof(delim) - 1;
