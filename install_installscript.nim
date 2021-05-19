import os, strformat

when declared(paramStr):
  if paramStr(1) == "--version":
    echo "Version: 0.1.1\nNOTE: This doesn't have to be the same version as the local_installer. This version number is the version of the installer of 'local_installer'. Not of 'local_installer' itself"
  elif paramStr(1) == "--help":
    echo "Usage: install_installscript [--version] [--help] [DIR/OF/local_installer]\nThis program installs the 'local_installer'. If you are in the same directory as the local_installer files, you can run this program without any other commands. If you aren't, you have to specify in which directory local_installer can be found."
else:
  echo "Assuming that the local_installer files can be found in the current directory"

try:
  createDir(expandTilde("~/.local/share/applications"))
  createDir(expandTilde("~/.local/bin/"))
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
  echo "Installation was successful!"
except:
  echo "Oh no! Something went wrong!"
