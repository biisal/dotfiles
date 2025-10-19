APP=$(echo -e "$(cat /home/avisek/.scripts/apps.txt)" | rofi -dmenu -i -p "Open which app?")
echo "$APP"
[ -n "$APP" ] || exit

BROWSER="brave"
[ -n "$1" ] && BROWSER=$1

URL=""
case "$APP" in
	whatsapp|telegram)	
		EXT="com"
		[ "$APP" == "telegram" ] && EXT="org"
		URL="https://web.$APP.$EXT"
		;;
	claude)
		URL="https://claude.ai"
		;;
	*)
		URL="https://$APP.com"
		;;

esac
[ -n "$URL" ] && $BROWSER --app=$URL
