# LZWolf -- A PortMaster implementation of LZWolf to play Wolfenstein 3D and friends

## Installation

This port comes with the shareware and demo for Wolfenstein 3D and Spear of Destiny. LZWolf can run the following games:

- [Wolfenstein 3D / Spear of Destiny](https://www.gog.com/en/game/wolfenstein_3d) - Place all `.WL6` files in the `lzwolf/Wolfenstein_3D` folder and all `.SOD` files in the `lzwolf/Spear_of_Destiny` folder.
- [Spear of Destiny Mission Packs]() - Place all `.SD2` and `.SD3` files in the `lzwolf/Spear_of_Destiny` folder.
- [Super 3D Noah's Ark](https://wisdomtree.itch.io/s3dna) - Place all `.N3D` fils in the `lzwolf/Super_3D_Noah's_Ark` folder.

 ## Play

 A Love2D launcher is planned, avoiding multiple `.sh` files. To use mods, place `.pk3` files in `ports/lzwolf` and list the `.pk3` files to load in `load.txt` for the relevant game.

 ## Mod

 The launcher lists folders as games and looks for `load.txt` files inside them. It uses their information to construct arguments passed to lzwolf. To create a `load.txt` file, open a text editor and add the following:

 - `PATH` - Path to the data files (the folder the `load.txt` file is in
 - `DATA` - File extension of the data files
 - `PK3_#` - Any `.pk3` files to load after the data, can use up to four

Follow this example `Wolfenstein_3D/load.txt` which launches vanilla Wolfenstein 3D:

```
PATH=./Wolfenstein_3D
DATA=WL6
PK3_1=breathing_fix.pk3
-- end --
```
