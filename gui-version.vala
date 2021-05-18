using Gtk;
using Gdk;

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
