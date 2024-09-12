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

#GAMEDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )/ecwolf"
GAMEDIR=/$directory/ports/ecwolf

cd $GAMEDIR

> "$GAMEDIR/log.txt" && exec > >(tee "$GAMEDIR/log.txt") 2>&1

if [[ "$DEVICE_NAME" == 'RG351P' ]] || [[ "$DEVICE_NAME" == 'RG351M' ]]; then
      ECWOLF_CONFIG="ecwolf_rg351p.cfg"
elif [[ "$DEVICE_NAME" == 'RG351V' ]]; then
      ECWOLF_CONFIG="ecwolf_rg351v.cfg"
elif [[ -e "/dev/input/by-path/platform-odroidgo2-joypad-event-joystick" ]]; then
    if [[ ! -z $(cat /etc/emulationstation/es_input.cfg | grep "190000004b4800000010000001010000") ]]; then
      ECWOLF_CONFIG="ecwolf_oga.cfg"
	else
      ECWOLF_CONFIG="ecwolf_rk2020.cfg"
   fi
elif [[ "$DEVICE_NAME" == 'ODROID-GO Super' ]]; then
      ECWOLF_CONFIG="ecwolf_ogs.cfg"
elif [[ "$DEVICE_NAME" == 'RGB30' ]]; then
      ECWOLF_CONFIG="ecwolf_rgb30.cfg"
elif [[ "$DEVICE_NAME" == 'x55' ]]; then
      ECWOLF_CONFIG="ecwolf_x55.cfg"
elif [[ "$DEVICE_NAME" == 'RG552' ]]; then
      ECWOLF_CONFIG="ecwolf_rg552.cfg"
elif [[ "$DEVICE_NAME" == 'RG503' ]]; then
      ECWOLF_CONFIG="ecwolf_rg503.cfg"
elif [[ "$DEVICE_NAME" == 'RG353P' ]]; then
      ECWOLF_CONFIG="ecwolf_rg353p.cfg"
elif [[ "$DEVICE_NAME" == 'RG40XX' ]]; then
      ECWOLF_CONFIG="ecwolf_rg40xx.cfg"
elif [[ "$ANALOG_STICKS" == '0' ]]; then
      ECWOLF_CONFIG="ecwolf_nojoy.cfg"
else
      ECWOLF_CONFIG="ecwolf_640x480.cfg"
fi

$ESUDO chmod 666 /dev/tty0
$ESUDO chmod 666 /dev/tty1
$ESUDO chmod 666 /dev/uinput

export DEVICE_ARCH="${DEVICE_ARCH:-aarch64}"
export LD_LIBRARY_PATH="$GAMEDIR/libs:$LD_LIBRARY_PATH"
export SDL_GAMECONTROLLERCONFIG="$sdl_controllerconfig"

$ESUDO chmod 777 -R $GAMEDIR/*

$GPTOKEYB "ecwolf" &
./ecwolf --config "./cfg/$ECWOLF_CONFIG" --data WL6 ./breathing_fix.pk3

$ESUDO kill -9 $(pidof gptokeyb)
$ESUDO systemctl restart oga_events &
printf "\033c" > /dev/tty1
printf "\033c" > /dev/tty0
