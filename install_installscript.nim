import os, strformat

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

var endmessage: string

if paramCount() == 1:
  if paramStr(1) == "--version":
    echo "Version: 0.1.1\nNOTE: This doesn't have to be the same version as the local_installer. This version number is the version of the installer of 'local_installer'. Not of 'local_installer' itself"
    endmessage = ""
  elif paramStr(1) == "--help":
    echo "Usage: install_installscript [--version] [--help] [DIR/OF/local_installer]\nThis program installs the 'local_installer'. If you are in the same directory as the local_installer files, you can run this program without any other commands. If you aren't, you have to specify in which directory local_installer can be found."
    endmessage = ""
else:
  echo "Assuming that the local_installer files can be found in the current directory"
  endmessage = "Oh no! Something went wrong!"

try:
  createDir(expandTilde("~/.cache"))
  createDir(expandTilde("~/.local/share/applications"))
  createDir(expandTilde("~/.local/bin"))
  when declared(paramStr):
    moveFile(&"{paramStr(1)}/local_installer", expandTilde("~/.local/bin/local_installer"))
    moveFile(&"{paramStr(1)}/local_installer-gui", expandTilde("~/.local/bin/local_installer-gui"))
  else:
    moveFile("local_installer", expandTilde("~/.local/bin/local_installer"))
    moveFile("local_installer-gui", expandTilde("~/.local/bin/local_installer-gui"))
  let shutUpNim = expandTilde("~/.local/bin/local_installer-gui")
  let desktopfile = &"[Desktop Entry]\nName=LocalInstaller\nComment=Locally install programs\nExec=\"{shutUpNim}\""
  let stupidnim = "\nTerminal=True\nType=Application\nCategories=Utility;"
  let desktop = &"{desktopfile}{stupidnim}"
  writeFile(expandTilde("~/.local/share/applications/local_installer.desktop"), desktop)
  discard execShellCmd("echo \"export PATH=$PATH:~/.local/bin\" >> ~/.bashrc")
  discard execShellCmd("chmod +x ~/.local/bin/local_installer;chmod +x ~/.local/bin/local_installer-gui")
  if fileExists(expandTilde("~/.config/mimeapps.list")):
    discard execShellCmd("LINE=$(awk '/vnd.debian.binary-package/{print NR;exit;}' ~/.config/mimeapps.list); if [[ -z $LINE ]]; then sed -i '2c application/vnd.debian.binary-package=local_installer.desktop;' ~/.config/mimeapps.list; else sed -i \"$LINE c application/vnd.debian.binary-package=local_installer.desktop;\" ~/.config/mimeapps.list; fi")
  else:
    writeFile(expandTilde("~/.config/mimeapps.list"), "[Added Associations]\napplication/vnd.debian.binary-package=local_installer.desktop;")
  echo "Installation was successful!"
except:
  echo endmessage
