# LZWolf -- A PortMaster implementation of LZWolf to play Wolfenstein 3D and friends
<div align="center">
  <img src="https://github.com/user-attachments/assets/7c94dfb7-b86a-421a-bd26-142900204663" alt="lzwolf-menu" width="480" height="320"/>
</div>

## Installation
This port comes with the shareware and demo for Wolfenstein 3D and Spear of Destiny. LZWolf can run the following games:

- [Wolfenstein 3D / Spear of Destiny](https://www.gog.com/en/game/wolfenstein_3d) - Place all `.WL6` files in the `lzwolf/Wolfenstein 3D` folder and all `.SOD` files in the `lzwolf/Spear of Destiny` folder.
- [Super Noah's Ark 3D](https://wisdomtree.itch.io/s3dna) - Place all `.N3D` fils in the `lzwolf/Super Noah's Ark 3D` folder.

## Play
To use addon mods, place `.pk3` files in `ports/lzwolf` and list the `.pk3` files to load in `.load.txt` for the relevant game.

## Mod
The launcher lists folders as games and looks for `.load.txt` files inside them. It uses their information to construct arguments passed to lzwolf. To create a `.load.txt` file, open a text editor and add the following:

- `PATH` - Path to the data files (the folder the `.load.txt` file is in)
- `DATA` - File extension of the data files
- `PK3_#` - Any `.pk3` files to load after the data, can use up to four

Follow this example `Wolfenstein 3D/.load.txt` which launches vanilla Wolfenstein 3D:

```
PATH=./Wolfenstein 3D
DATA=WL6
PK3_1=breathing_fix.pk3
-- end --
```

## Building
See [PM-LZWolf](https://github.com/JeodC/pm-lzwolf) GitHub fork for compile instructions and change information.

## Thanks
id Software -- Original game  
Linuxwolf -- LZWolf  
Richard Douglas -- The free [music](https://richdouglasmusic.bandcamp.com/album/wolfenstein-symphony-music-inspired-by-wolfenstein-3d) used for the launcher  
Slayer366 -- Port assistance  
PortMaster Discord -- Testers
