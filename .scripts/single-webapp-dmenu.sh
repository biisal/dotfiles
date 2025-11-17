APP=$(echo -e "$(cat /home/avisek/.scripts/apps.txt)" | tofi --prompt-text "Open which app?: ")
echo "$APP"
[ -n "$APP" ] || exit

BROWSER="firefox"
[ -n "$1" ] && BROWSER=$1

URL=""
case "$APP" in
    whatsapp|telegram)
        EXT="com"
        [ "$APP" = "telegram" ] && EXT="org"
        URL="https://web.$APP.$EXT"
        ;;
    claude)
        URL="https://claude.ai"
        ;;
    *)
        URL="https://$APP.com"
        ;;
esac

if [ "$BROWSER" = "brave" ]; then
    [ -n "$URL" ] && "$BROWSER" --app="$URL"
elif [ "$BROWSER" = "firefox" ]; then
    [ -n "$URL" ] && "$BROWSER" --kiosk "$URL"
fi
