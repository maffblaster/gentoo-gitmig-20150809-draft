# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-light/gnome-light-2.6.ebuild,v 1.4 2004/07/11 19:59:42 spider Exp $

S=${WORKDIR}
DESCRIPTION="Meta package for the GNOME desktop, merge this package to install"
HOMEPAGE="http://www.gnome.org/"
LICENSE="as-is"
SLOT="2.0"
IUSE=""

# when unmasking for an arch
# double check none of the deps are still masked !
KEYWORDS="x86 ~ppc amd64"

#  Note to developers:
#  This is a wrapper for the 'light' Gnome2 desktop,
#  This should only consist of the bare minimum of libs/apps needed
#  It is basicly the gnome-base/gnome without all extra apps

#  This is currently in it's test phase, if you feel like some dep
#  should be added or removed from this pack file a bug to
#  gnome@gentoo.org on bugs.gentoo.org

#	>=media-gfx/eog-2.2.1

RDEPEND="!gnome-base/gnome-core
	!gnome-base/gnome

	>=x11-wm/metacity-2.8
	>=gnome-base/gnome-session-2.6
	>=gnome-base/eel-2.6
	>=gnome-base/nautilus-2.6
	>=x11-terms/gnome-terminal-2.6
	>=gnome-base/control-center-2.6.0.3
	>=gnome-extra/yelp-2.6

	>=gnome-base/gnome-mime-data-2.4.1
	>=x11-misc/shared-mime-info-0.14
	>=gnome-base/gnome-vfs-2.6

	>=x11-libs/gtk+-2.4.0-r1
	>=x11-libs/pango-1.4
	>=dev-libs/atk-1.6
	>=dev-libs/glib-2.4
	>=gnome-base/gconf-2.6
	>=gnome-base/gnome-panel-2.6
	>=gnome-base/gnome-desktop-2.6.0.1
	>=gnome-base/libbonobo-2.6
	>=gnome-base/libbonoboui-2.6
	>=gnome-base/libgnome-2.6
	>=gnome-base/libgnomecanvas-2.6
	>=gnome-base/libgnomeui-2.6
	>=gnome-base/librsvg-2.6.4
	>=gnome-base/libglade-2.3.6
	>=x11-libs/libwnck-2.4.0.1-r1
	>=gnome-base/ORBit2-2.10

	>=x11-themes/gnome-icon-theme-1.2
	>=x11-themes/gnome-themes-2.6"

pkg_postinst () {

	einfo "note that to change windowmanager to metacity do: "
	einfo " export WINDOW_MANAGER=\"/usr/bin/metacity\""
	einfo "of course this works for all other window managers as well"
	einfo ""
	ewarn "Remember, this meta package is experimental !"
	einfo ""
	einfo "Use gnome-base/gnome for the full GNOME Desktop"
	einfo "as released by the GNOME team."

}
