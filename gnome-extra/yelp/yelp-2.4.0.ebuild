# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/yelp/yelp-2.4.0.ebuild,v 1.5 2003/10/22 12:03:13 darkspecter Exp $

inherit gnome2

DESCRIPTION="Help browser for Gnome"
HOMEPAGE="http://www.gnome.org/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc alpha ~hppa amd64"

RDEPEND=">=dev-libs/glib-2.0.6
	>=gnome-base/gconf-1.2
	>=gnome-base/libgnome-2.0.2
	>=gnome-base/libgnomeui-2
	>=gnome-base/gnome-vfs-2
	>=gnome-base/libbonobo-2
	=gnome-extra/libgtkhtml-2*
	>=dev-libs/libxslt-1.0.15
	>=gnome-base/libglade-2
	dev-libs/popt
	sys-libs/zlib"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README TODO"
