# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header:

NAME=Whiteboard
S="${WORKDIR}/${NAME}-${PV}"
DESCRIPTION="Virtual net-whiteboard."
SRC_URI="http://hem.fyristorg.com/matben/download/${NAME}-${PV}.tar.gz"
HOMEPAGE="http://hem.fyristorg.com/matben"
LICENSE="GPL-2"
DEPEND="dev-lang/tk"
RDEPEND="${DEPEND}"
KEYWORDS="x86"
SLOT="0"

src_compile() {
	einfo "Nothing to compile for ${P}."
}

src_install () {
	dodir /opt/coccinella
	cp -r ${WORKDIR}/${NAME}-${PV}/* ${D}/opt/coccinella/
	dosym /opt/coccinella/Whiteboard.tcl /opt/coccinella/coccinella
	insinto /etc/env.d
    doins ${FILESDIR}/97coccinella 
	dodoc CHANGES README
}
