using Gtk;
using Gdk;

static void installer(string filepath,status stat) {
string[] fileparts = filepath.split("/");
string filename = fileparts[fileparts.length - 1];
stat.set_text(@"Status...\nApplication to install: $filename");
if (".deb" in filename) {
	string HOME = Environment.get_variable("HOME");
	stat.set_text(@"$(stat.get_text())\nDetected .deb architecture.");
	string tmpdir = "$HOME/.cache/" + filename;
	print(tmpdir);
	Posix.system(@"mkdir $tmpdir");
	Posix.system(@"cd $tmpdir;mv $filepath .;ar -x $filename;");
Posix.system(@"cd $tmpdir;if ! ls | grep -q \"data.tar\"; then cd *; fi; if ls | grep  \"data.tar.xz\"; then tar -xJf data.tar.xz;  elif ls | grep -q \"data.tar.gz\"; then tar -xzf data.tar.gz;  else echo \"ERROR: file type of data archive was not understood\"; fi;cd usr; cp -r * $HOME/.local/");
Posix.system("""if ! echo $PATH | grep /\.local/bin; then export PATH=$PATH:~/.local/bin; fi""");
	Posix.system("""if ! cat $HOME/.bashrc | grep /\.local/bin; then echo "export PATH=$PATH:~/.local/bin"; fi""");
	Posix.system("cd ../../../");
	Posix.system(@"rm -rf $tmpdir");
	stat.set_text(@"$(stat.get_text())\nInstallation was successful!");
}

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
var file_chooser = new FileChooserDialog ("Select File", window, FileChooserAction.OPEN,                               "_Cancel", ResponseType.CANCEL, "_Select", ResponseType.ACCEPT);
        if (file_chooser.run () == ResponseType.ACCEPT) {
                char *filename;
                filename = file_chooser.get_filename ();
                installer((string)filename, stat);
        }
        file_chooser.destroy ();

grid.attach (stat, 0,0,1,1);    
window.add (grid);

    window.set_default_size (450, 50);

    window.destroy.connect(Gtk.main_quit);

    window.show_all ();

    Gtk.main ();

    return 0;
}
