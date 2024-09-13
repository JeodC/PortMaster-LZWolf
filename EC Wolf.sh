#!/bin/bash

XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

if [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
elif [ -d "$XDG_DATA_HOME/PortMaster/" ]; then
  controlfolder="$XDG_DATA_HOME/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

source $controlfolder/control.txt
source $controlfolder/device_info.txt
[ -f "${controlfolder}/mod_${CFW_NAME}.txt" ] && source "${controlfolder}/mod_${CFW_NAME}.txt"
get_controls

# Variables
GAMEDIR="/$directory/ports/ecwolf"
HEIGHT=$DISPLAY_HEIGHT
WIDTH=$DISPLAY_WIDTH
DATA="Wolfenstein 3D.ecwolf" # Returned from Love2D launcher

cd $GAMEDIR
> "$GAMEDIR/log.txt" && exec > >(tee "$GAMEDIR/log.txt") 2>&1

# Create config dir
rm -rf "$XDG_DATA_HOME/ecwolf"
ln -s "$GAMEDIR/cfg" "$XDG_DATA_HOME/ecwolf"

# Permissions
$ESUDO chmod 666 /dev/tty0
$ESUDO chmod 666 /dev/tty1
$ESUDO chmod 666 /dev/uinput
$ESUDO chmod 777 -R $GAMEDIR/*

# Exports
export LD_LIBRARY_PATH="$GAMEDIR/libs:$LD_LIBRARY_PATH"
export SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig"
export SDL_GAMECONTROLLERCONFIG_FILE="$sdl_controllerconfig"

# Select a config file
if [ "${ANALOG_STICKS}" == 0 ]; then
    CONFIG="./cfg/nosticks.cfg"
else
    CONFIG="./cfg/ecwolf.cfg" 
fi

# Modify the config file
if [ $WIDTH -eq $HEIGHT ]; then # RGB30 or 1:1
    HEIGHT=540
fi
if [ $HEIGHT -gt 1080 ]; then # RG552
    HEIGHT=1080
fi

sed -i "s/^FullScreenHeight = [0-9]\+/FullScreenHeight = $HEIGHT/" "$CONFIG"
sed -i "s/^FullScreenWidth = [0-9]\+/FullScreenWidth = $WIDTH/" "$CONFIG"

# Build args
ARGS="--config $CONFIG --savedir ./cfg"
if [ -n "$DATA" ]; then
    dos2unix "$DATA"
    TMP=$IFS
    while IFS== read -r key value; do
        case "$key" in
            DATA)
                ARGS+=" --data $value"
                ;;
            PK3|PK3_1|PK3_2|PK3_3|PK3_4)
                ARGS+=" --file $value"
                ;;
        esac
    done < "$DATA"
    IFS=$TMP
else
    ARGS+=" --data ${DATA}"
fi

# Run game
echo "Running ecwolf with args: ${ARGS}"
$GPTOKEYB "ecwolf" &
./ecwolf $ARGS

$ESUDO kill -9 $(pidof gptokeyb)
$ESUDO systemctl restart oga_events &
printf "\033c" > /dev/tty1
printf "\033c" > /dev/tty0