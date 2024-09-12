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
GAMEDIR=/$directory/ports/ecwolf
DATA=$1${1#*.}

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

# Mod Parsing
ARGS="--config $CONFIG--savedir $GAMEDIR/cfg"
if [ "${DATA}" == "ecwolf" ]; then
    dos2unix "${1}"
    while IFS== read -r key value; do
        case "$key" in
            DATA)
                ARGS+=" --data $value"
                ;;
            PK3|PK3_1|PK3_2|PK3_3|PK3_4)
                ARGS+=" --file $value"
                ;;
        esac
    done < "${1}"
else
    ARGS+=" --data ${DATA}"
fi

# Run game
$GPTOKEYB "ecwolf" &
./ecwolf --config "./cfg/ecwolf.cfg" --data WL6 ./breathing_fix.pk3

$ESUDO kill -9 $(pidof gptokeyb)
$ESUDO systemctl restart oga_events &
printf "\033c" > /dev/tty1
printf "\033c" > /dev/tty0
