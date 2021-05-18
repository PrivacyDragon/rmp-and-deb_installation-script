# rmp-and-deb_installation-script
This is a script that locally isntalls .rpm and .deb files. this is ideal if you don't have root access.

## Installation
* Extract the .tar.gz file
* Open a terminal window and run `cd /FOLDER/OF/local_installer`
* run `chmod +x install_installscript`
* run `./install_installscript`
* run `echo "export PATH=$PATH:$HOME/.local/bin" >> ~/.bashrc`
* You can now access the program via the commandline with `local_installer FILE` for the CLI version and `local_installer-gui` for the GUI version.
* There should also be a desktop entry.
### There is not much documentation yet, I will add more in the future.
Use:
CLI version: `local_installer <FILE>` Please be aware that you should do this from the directory where the file is located.<br>
GUI version: `local_installer-gui`, select a file.

## Known problems
* Currently you have to be in the same directory as the .deb or .rpm file when you use the CLI version. (I will fix this very soon).
* The GUI is probably kinda messy (I might fix this once I am done with the other things, but it has a quite low priority).
* I am not sure if it will work on all systems, because one thing might not work everywhere or something? (I will fix this very soon).
