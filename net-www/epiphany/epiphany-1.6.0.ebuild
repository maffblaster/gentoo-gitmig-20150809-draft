# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/epiphany/epiphany-1.6.0.ebuild,v 1.1 2005/03/09 05:10:24 joem Exp $

inherit eutils gnome2

DESCRIPTION="GNOME webbrowser based on the mozilla rendering engine"
HOMEPAGE="http://www.gnome.org/projects/epiphany/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ia64"
IUSE="doc"

RDEPEND=">=dev-libs/glib-2.6
	>=x11-libs/pango-1.8
	>=x11-libs/gtk+-2.6.3
	>=gnome-base/gconf-1.2
	>=dev-libs/libxml2-2.6.12
	>=dev-libs/libxslt-1.1.7
	>=gnome-base/libgnomeui-2.6.0
	>=gnome-base/libglade-2.3.1
	>=gnome-base/libbonoboui-2.2
	>=gnome-base/orbit-2
	>=gnome-base/gnome-vfs-2.3.1
	>=net-www/mozilla-1.7.3
	>=x11-themes/gnome-icon-theme-2.9.3
	gnome? ( >=gnome-base/nautilus-2.5 )
	|| ( >=net-www/mozilla-1.7
		 >=net-www/mozilla-firefox-0.10 )"
# dbus? ( >=sys-apps/dbus-0.22 )

DEPEND="${RDEPEND}
	app-text/scrollkeeper
	dev-util/pkgconfig
	>=dev-util/intltool-0.29
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README TODO"

MAKEOPTS="${MAKEOPTS} -j1"

pkg_setup() {

	if [ ! -f ${ROOT}/usr/lib/mozilla/components/libwidget_gtk2.so ]
	then
		eerror "you need mozilla-1.7.3+ compiled against gtk+-2"
		eerror "export USE=\"gtk2\" ;emerge mozilla -p "
		die "Need Mozilla compiled with gtk+-2.0!"
	fi

}

src_unpack() {

	unpack ${A}
	cd ${S}
	# Fix include paths for our mozilla
	epatch ${FILESDIR}/${PN}-1.5.5-fix_includes.patch

}
USE_DESTDIR="1"
