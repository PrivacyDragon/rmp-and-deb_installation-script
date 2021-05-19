using Gtk;
using Gdk;

/*Licensed under the BSD 3-clause license
Copyright (c) 2021, Privacy_Dragon
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.

3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.*/

static void installer(string filepath,status stat) {
        string[] fileparts = filepath.split("/");
        string filename = fileparts[fileparts.length - 1];
        stat.set_text(@"Status...\nApplication to install: $filename");
        string tmpdir = "$HOME/.cache/" + filename;
        if (".deb" in filename) {
                stat.set_text(@"$(stat.get_text())\nDetected .deb architecture.");
        }
        else if (".rpm" in filename) {
                stat.set_text(@"$(stat.get_text())\nDetected .rpm architecture.");
        }
        else {
                stat.set_text(@"$(stat.get_text())\nERROR: Non-supported architecture detected!");
        }
        Posix.system(@"mkdir $tmpdir");
        Posix.system(@"cd $tmpdir; wget -q https://raw.githubusercontent.com/PrivacyDragon/rmp-and-deb_installation-script/main/install_rpm-deb_locally; chmod +x install_rpm-deb_locally; ./install_rpm-deb_locally $filepath");
        stat.set_text(@"$(stat.get_text())\nIf there are no errors in the console and the output above, the installation was successful!");
}

public class status : Label {
        public status () {
                set_text("Status...");
        }
}
 
static int main (string[] args) {
        Gtk.init (ref args);
        var window = new Gtk.Window (Gtk.WindowType.TOPLEVEL);
        var grid = new Grid();
        grid.orientation = Orientation.HORIZONTAL;
        grid.row_homogeneous = false;
        grid.row_spacing = 5;
        grid.column_spacing = 400;
        var  stat = new status(); 
        grid.attach (stat, 0,0,1,1);
        window.add(grid);
        window.set_default_size(300,300);
        var file_chooser = new FileChooserDialog ("Select File", window, FileChooserAction.OPEN, "_Cancel", ResponseType.CANCEL, "_Select", ResponseType.ACCEPT);
        if (file_chooser.run () == ResponseType.ACCEPT) {
                char *filename;
                filename = file_chooser.get_filename ();
                installer((string)filename, stat);
        }
        file_chooser.destroy ();
    	window.destroy.connect(Gtk.main_quit);
    	window.show_all ();
    	Gtk.main ();
	return 0;
}
