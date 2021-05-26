#!/bin/sh -e

#Licensed under the BSD 3-clause license
#Copyright (c) 2021, Privacy_Dragon
#All rights reserved.
#
#Redistribution and use in source and binary forms, with or without
#modification, are permitted provided that the following conditions are met:
#
#1. Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#
#2. Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
#3. Neither the name of the copyright holder nor the names of its
#   contributors may be used to endorse or promote products derived from
#   this software without specific prior written permission.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
#AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
#FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
#SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
#CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
#OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
#OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
if echo "$1" | grep -q "\-\-version"; then
    echo "Version: 0.3.0\nNOTE: This doesn't have to be the same version as the local_installer. This version number is the version of the installer of 'local_installer'. Not of 'local_installer' itself"
elif echo "$1" | grep -q "\-\-help"; then
    echo "Usage: install_installscript [--version] [--help] [DIR/OF/local_installer]\nThis program installs the 'local_installer'. If you are in the same directory as the local_installer files, you can run this program without any other commands. If you aren't, you have to specify in which directory local_installer can be found."
else
  echo "Assuming that the local_installer files can be found in the current directory"
fi
mkdir "~/.config" 2>/dev/null
mkdir "~/.local/share/applications" 2>/dev/null
mkdir "~/.local/bin" 2>/dev/null
if ! [[ -z $1 ]]; then
  mv $1/local_installer ~/.local/bin/local_installer
  mv $1/local_installer-gui ~/.local/bin/local_installer-gui
else
  mv local_installer ~/.local/bin/local_installer
  mv local_installer-gui ~/.local/bin/local_installer-gui
fi
desktopfile="[Desktop Entry]\nName=LocalInstaller\nComment=Locally install programs\nExec=\"~/.local/bin/local_installer-gui\"\nTerminal=False\nType=Application\nCategories=Utility;"
printf "$desktopfile" > ~/.local/share/applications/local_installer.desktop
echo "export PATH=$PATH:~/.local/bin" >> ~/.bashrc
chmod +x ~/.local/bin/local_installer
chmod +x ~/.local/bin/local_installer-gui
if [ -e ~/.config/mimeapps.list ]; then
  LINE=$(awk '/vnd.debian.binary-package/{print NR;exit;}' ~/.config/mimeapps.list)
  if [[ -z $LINE ]]; then
    sed -i '2c application/vnd.debian.binary-package=local_installer.desktop;' ~/.config/mimeapps.list
  else
    sed -i "$LINE c application/vnd.debian.binary-package=local_installer.desktop;" ~/.config/mimeapps.list
  fi
  LINE=$(awk '/x-rpm/{print NR;exit;}' ~/.config/mimeapps.list)
   if [[ -z $LINE ]]; then
     sed -i '2c application/x-rpm=local_installer.desktop;' ~/.config/mimeapps.list
   else
     sed -i "$LINE c application/x-rpm=local_installer.desktop;" ~/.config/mimeapps.list
   fi
else
  printf "[Added Associations]\napplication/vnd.debian.binary-package=local_installer.desktop;\napplication/x-rpm=local_installer.desktop;" > ~/.config/mimeapps.list
fi
echo "Installation was successful!"
