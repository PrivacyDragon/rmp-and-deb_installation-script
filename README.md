# rmp-and-deb_installation-script
This is a script that locally isntalls .rpm and .deb files. this is ideal if you don't have root access.

## Installation
* Extract the .tar.gz file
* Open a terminal window and run `cd /FOLDER/OF/local_installer`
* run `sh install_installscript.sh`
* You can now access the program via the commandline with `local_installer FILE` for the CLI version and `local_installer-gui` for the GUI version.
* There should also be a desktop entry.
### There is not much documentation yet, I will add more in the future.
Use:<br>
CLI version: `local_installer <FILE>`<br>
GUI version: `local_installer-gui`, select a file.

## Known problems
* The GUI is probably kinda messy (I might fix this once I am done with the other things, but it has a quite low priority).

## TODO
* Build in some checks
* Make sure the .desktop files point to local locations.
