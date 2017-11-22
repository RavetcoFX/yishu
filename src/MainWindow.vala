using Gtk;

namespace Td {
	public class TodoWindow : Gtk.Window {

		public Gtk.Box info_bar_box;
		public Gtk.HeaderBar toolbar;
		public Gtk.Button open_button;
		public Gtk.Button add_button;
		public Granite.Widgets.Welcome welcome;
		public Gtk.TreeView tree_view;
		public Gtk.CellRendererToggle cell_renderer_toggle;

		construct {
      var provider = new Gtk.CssProvider ();
      provider.load_from_resource ("/com/github/lainsce/yishu/stylesheet.css");
      Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);

			title = "Yishu";

			/* Layout and containers */
			var vbox = new Box(Gtk.Orientation.VERTICAL, 0);
			var vbox2 = new Stack();
			var swin = new ScrolledWindow(null, null);

			welcome = new Granite.Widgets.Welcome("No Todo.txt File Open", _("Open a todo.txt file to start adding tasks"));
			welcome.append("appointment-new", _("Add task"), _("Start a new todo.txt file by adding a task"));
			welcome.append("document-open", _("Open file"), _("Use an existing todo.txt file"));
			welcome.append("help-contents", _("What is a todo.txt file?"), _("Learn more about todo.txt files"));

			/* Create toolbar */
			toolbar = new HeaderBar();
      this.set_titlebar(toolbar);
      toolbar.set_show_close_button (true);
      toolbar.has_subtitle = false;
      toolbar.set_title("Yishu");
			open_button = new Gtk.Button ();
      open_button.set_image (new Gtk.Image.from_icon_name ("document-open", Gtk.IconSize.LARGE_TOOLBAR));
      open_button.has_tooltip = true;
      open_button.tooltip_text = (_("Open…"));
			add_button = new Gtk.Button ();
      add_button.set_image (new Gtk.Image.from_icon_name ("appointment-new", Gtk.IconSize.LARGE_TOOLBAR));
      add_button.has_tooltip = true;
      add_button.tooltip_text = (_("Add task…"));
			toolbar.pack_start(open_button);
			toolbar.pack_start(add_button);

			tree_view = setup_tree_view();
			swin.add(tree_view);
			vbox2.add(welcome);
			vbox2.add(swin);

			// Info Bar
			info_bar_box = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
			vbox.pack_start(info_bar_box, false, false, 0);
			vbox.pack_start(vbox2, true, true, 0);
			add(vbox);

			show_all();
		}

		private TreeView setup_tree_view(){
			TreeView tv = new TreeView();
			TreeViewColumn col;

			col = new TreeViewColumn.with_attributes(_("Priority"), new Granite.Widgets.CellRendererBadge(), "text", Columns.PRIORITY);
			col.set_sort_column_id(Columns.PRIORITY);
			col.resizable = true;
			tv.append_column(col);

			col = new TreeViewColumn.with_attributes(_("Task"), new CellRendererText(), "markup", Columns.MARKUP);
			col.set_sort_column_id(Columns.MARKUP);
			col.resizable = true;
      col.expand = true;
			tv.append_column(col);

			cell_renderer_toggle = new CellRendererToggle();
			cell_renderer_toggle.activatable = true;
			col = new TreeViewColumn.with_attributes(_("Done"), cell_renderer_toggle, "active", Columns.DONE);
			col.set_sort_column_id(Columns.DONE);
			col.resizable = true;
			tv.append_column(col);

			return tv;
		}
	}
}
