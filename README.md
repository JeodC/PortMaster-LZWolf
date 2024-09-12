# ECWolf -- A PortMaster implementation of ECWolf to play Wolfenstein 3D and friends

## Installation

This port comes with the shareware and demo for Wolfenstein 3D and Spear of Destiny. ECWolf is v.1.4.1 which is current as of 09/12/2024. ECWolf can run the following games:

- [Wolfenstein 3D / Spear of Destiny](https://www.gog.com/en/game/wolfenstein_3d) - Place all `.WL6` files in the `ecwolf/wolf3d` folder and all `.SOD` files in the `ecwolf/sod` folder.
- [Spear of Destiny Mission Packs]() - Place all `.SD2` and `.SD3` files in the `ecwolf/sod` folder.
- [Super 3D Noah's Ark](https://wisdomtree.itch.io/s3dna) - Place all `.N3D` fils in the `ecwolf/n3d` folder.

 ## Play

 A Love2D launcher is planned, avoiding multiple `.sh` files. ECWolf does support mods, instructions for mods are pending however.

 ## Mod

 The launcher looks for `.ecwolf` files and uses their information to construct arguments passed to ecwolf. To create a `.ecwolf` file, open a text editor and add the following:

 - `PATH` - Path to the data files
 - `DATA` - File extension of the data files
 - `PK3_#` - Any `.pk3` files to load after the data, can use up to four

Follow this example `Wolfenstein 3D.ecwolf` which launches vanilla Wolfenstein 3D:

```
PATH=./wolf3d
DATA=WL6
PK3_1=breathing_fix.pk3
-- end --
```
