# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/libgsf/libgsf-1.8.1.ebuild,v 1.2 2003/06/30 18:15:10 darkspecter Exp $

inherit gnome2

IUSE="gnome doc"
DESCRIPTION="The GNOME Structured File Library"
HOMEPAGE="http://www.gnome.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~x86 ~sparc  ppc"

# FIXME : should add optional bz2 support
RDEPEND=">=dev-libs/libxml2-2.4.16
	 >=dev-libs/glib-2
	 >=sys-libs/zlib-1.1.4
	 gnome? ( >=gnome-base/libbonobo-2
	  	>=gnome-base/gnome-vfs-2 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	doc? ( >=dev-util/gtk-doc-0.9 )" 

src_unpack() {
	unpack ${A}
	cd ${S}/doc/

	# little hack to fix bug 7570
	cp Makefile.in Makefile.in.orig
	sed -e "s:doc\$(TARGET_DIR):\$(TARGET_DIR):" \
		Makefile.in.orig > Makefile.in
}

use gnome \
	&& G2CONF="${G2CONF} --with-gnome" \
	|| G2CONF="${G2CONF} --without-gnome"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"
