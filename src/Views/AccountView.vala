// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
/*-
 * Copyright (c) 2013 Pantheon Developers (http://launchpad.net/online-accounts-plug)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 *
 * Authored by: Corentin Noël <tintou@mailoo.org>
 */

public class OnlineAccounts.AccountView : Gtk.Grid {
    Gtk.Grid main_grid;
    OnlineAccounts.Account plugin;

    public AccountView (OnlineAccounts.Account plugin) {
        this.plugin = plugin;
        main_grid = new Gtk.Grid ();
        main_grid.margin = 12;
        main_grid.column_spacing = 6;
        main_grid.row_spacing = 6;
        
        string label_str = plugin.account.manager.get_provider (plugin.account.get_provider_name ()).get_display_name ();
        var name = plugin.account.get_display_name ();
        if (name != "" && name != null) {
            label_str = "%s - %s".printf (plugin.account.get_display_name (), label_str);
        }

        var user_label = new Gtk.Label (Markup.escape_text (label_str));
        Granite.Widgets.Utils.apply_text_style_to_label (Granite.TextStyle.H2, user_label);
        user_label.hexpand = true;

        var apps_label = new Gtk.Label ("");
        apps_label.set_markup ("<b>%s</b>".printf (Markup.escape_text (_("Applications that use this service:"))));
        apps_label.xalign = 0;
        apps_label.margin_top = 12;

        var scrolled_window = new Gtk.ScrolledWindow (null, null);
        scrolled_window.hscrollbar_policy = Gtk.PolicyType.NEVER;
        scrolled_window.expand = true;

        var apps_grid = new Gtk.Grid ();
        apps_grid.margin_bottom = 12;
        apps_grid.margin_left = 12;
        apps_grid.margin_right = 12;
        apps_grid.column_spacing = 12;
        apps_grid.row_spacing = 6;

        int i = 0;
        foreach (var service in plugin.account.list_services ()) {
            foreach (var app in plugin.account.manager.list_applications_by_service (service)) {
                if (app == null)
                    continue;
                var app_info = app.get_desktop_app_info ();
                string i18n_domain = null;
                if (app_info != null) {
                    i18n_domain = app_info.get_string ("X-GNOME-Gettext-Domain");
                    if (i18n_domain == null)
                        i18n_domain = app_info.get_string ("X-Ubuntu-Gettext-Domain");
                }

                if (i18n_domain == null)
                    i18n_domain = app.get_i18n_domain ();

                Gtk.Image service_image;
                if (app_info != null)
                    service_image = new Gtk.Image.from_gicon (app_info.get_icon (), Gtk.IconSize.DIALOG);
                else
                    service_image = new Gtk.Image.from_icon_name ("application-default-icon", Gtk.IconSize.DIALOG);

                service_image.margin_left = 12;

                var service_label = new Gtk.Label ("");
                if (app_info != null)
                    service_label.set_markup ("<big>%s</big>".printf (Markup.escape_text (GLib.dgettext (i18n_domain, app_info.get_string ("Name")))));
                else
                    service_label.set_markup ("<big>%s</big>".printf (Markup.escape_text (GLib.dgettext (i18n_domain, app.get_name ()))));

                service_label.xalign = 0;

                var service_description_label = new Gtk.Label (GLib.dgettext (app.get_i18n_domain (), app.get_service_usage (service)));
                service_description_label.xalign = 0;

                var service_labels_grid = new Gtk.Grid ();
                service_labels_grid.hexpand = true;
                service_labels_grid.margin = 6;
                service_labels_grid.row_spacing = 6;
                service_labels_grid.attach (service_label, 0, 0, 1, 1);
                service_labels_grid.attach (service_description_label, 0, 1, 1, 1);

                var service_switch = new Gtk.Switch ();
                service_switch.valign = Gtk.Align.CENTER;
                plugin.account.select_service (service);
                service_switch.active = plugin.account.get_enabled ();
                service_switch.notify["active"].connect (() => {on_service_switch_activated (service_switch.active, service);});

                apps_grid.attach (service_image, 0, i, 1, 1);
                apps_grid.attach (service_labels_grid, 1, i, 1, 1);
                apps_grid.attach (service_switch, 2, i, 1, 1);
                i++;
            }
        }

        if (i == 0) {
            apps_label.set_markup ("<b>%s</b>".printf (Markup.escape_text (_("There is no application using this account."))));
        }

        plugin.account.select_service (null);

        scrolled_window.add_with_viewport (apps_grid);
        main_grid.attach (user_label, 0, 0, 1, 1);
        main_grid.attach (apps_label, 0, 1, 1, 1);
        this.attach (main_grid, 0, 0, 1, 1);
        this.attach (scrolled_window, 0, 1, 1, 1);
    }
    
    private void on_service_switch_activated (bool enabled, Ag.Service service) {
        plugin.account.select_service (service);
        plugin.account.set_enabled (enabled);
        plugin.account.store_async.begin (null);
        plugin.account.select_service (null);
    }
    
}