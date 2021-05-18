import os, strformat

try:
  createDir(expandTilde("~/.local/share/applications"))
  createDir(expandTilde("~/.local/bin/"))
  moveFile("local_installer", expandTilde("~/.local/bin/local_installer"))
  moveFile("local_installer-gui", expandTilde("~/.local/bin/local_installer-gui"))
  let shutUpNim = expandTilde("~/.local/bin/local_installer-gui")
  let desktopfile = &"[Desktop Entry]\nName=LocalInstaller\nComment=Locally install programs\nExec=\"{shutUpNim}\""
  let stupidnim = "\nTerminal=True\nType=Application\nCategories=Utility;"
  let desktop = &"{desktopfile}{stupidnim}"
  writeFile(expandTilde("~/.local/share/applications/local_installer.desktop"), desktop)
  discard execShellCmd("echo \"export PATH=$PATH:~/.local/bin\" >> ~/.bashrc")
except:
  echo "Oh no! Something went wrong!"





