# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/gtkwave/gtkwave-2.0.0_pre20021022.ebuild,v 1.4 2003/03/26 10:15:21 seemant Exp $

MY_P="${P/_pre/pre1-}"
DESCRIPTION="A wave viewer for LXT and Verilog VCD/EVCD files"
HOMEPAGE="http://www.cs.man.ac.uk/amulet/tools/gtkwave/"
SRC_URI="ftp://ftp.cs.man.ac.uk/pub/amulet/gtkwave/snapshots/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"
IUSE=""

DEPEND="virtual/x11
	=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*
	sys-apps/bzip2"

S="${WORKDIR}/${MY_P}"

src_compile() {
	local myconf="--with-gnu-ld"

	econf ${myconf}
	emake || die
}

src_install() {
	emake DESTDIR=${D} install || die
}
