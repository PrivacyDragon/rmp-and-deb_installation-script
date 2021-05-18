# rmp-and-deb_installation-script
This is a script that locally isntalls .rpm and .deb files. this is ideal if you don't have root access.

## Installation
* Extract the .tar.gz file
* Open a terminal window and run `cd /FOLDER/OF/local_installer`
* run `chmod +x install_installscript`
* run `./install_installscript`
* run `export PATH=$PATH:$HOME/.local/bin`
* You can now access the program via the commandline with `local_installer FILE` for the CLI version and `local_installer-gui` for the GUI version.
* There should also be a desktop entry.
### There is not much documentation yet, I will add more in the future.
Use:
CLI version: `local_installer <FILE>`
GUI version: `local_installer-gui`, select a file.
