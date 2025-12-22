
if [ "$1" == "1" ]; then
	echo "Setting laptop speaker"
	pactl set-default-sink alsa_output.pci-0000_03_00.1.hdmi-stereo
else
	echo "Settig monitor speaker"
	pactl set-default-sink alsa_output.pci-0000_03_00.6.analog-stereo 
fi

