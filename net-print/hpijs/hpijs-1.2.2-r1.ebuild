# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/hpijs/hpijs-1.2.2-r1.ebuild,v 1.3 2003/09/26 12:26:28 lanius Exp $

# Though this program runs on it's own it makes no sense to run it without ghostscript

RSS_PATCH=${P}-rss.2.patch

S=${WORKDIR}/${P}
DESCRIPTION="The HP Inkjet server for Ghostscript. Provides best output for HP Inkjet Printers and some LaserJets"
HOMEPAGE="http://hpinkjet.sourceforge.net"
KEYWORDS="~x86 ~ppc"
SRC_URI="mirror://sourceforge/hpinkjet/${P}.tar.gz
	http://www.linuxprinting.org/download/printing/${PN}/${RSS_PATCH}"
DEPEND="virtual/glibc"
RDEPEND="${DEPEND} app-text/ghostscript"
LICENSE="as-is"
SLOT="0"

src_unpack() {
	unpack ${P}.tar.gz ; cd ${S}
	patch -p1 <${DISTDIR}/${RSS_PATCH} || die
}

src_compile () {
	econf --host=${CHOST} || die "bad ./configure"
	make || die "compile problem"
}

src_install () {
	einstall || die
	# fix the doc dir, it needs to have the package revision..
	mv ${D}/usr/share/doc/${P} ${D}/usr/share/doc/${PF}
}

pkg_postinst () {
	if [ "`use cups`" ] ; then
		einfo "To use the hpijs driver with the cups spooler, you will need the .ppd file"
		einfo "for your printer.  You may obtain it from:"
		einfo "http://www.linuxprinting.org/show_driver.cgi?driver=hpijs"
		einfo "Install it in /usr/share/cups/model.  After restarting cups you should be"
		einfo "able to use the new driver."
	else
		einfo "To use the hpijs driver with the PDQ spooler you will need the PDQ driver file"
		einfo "for your printer from http://www.linuxprinting.org/show_driver.cgi?driver=hpijs"
		einfo "This file should be installed in /etc/pdq/drivers"
	fi
}
