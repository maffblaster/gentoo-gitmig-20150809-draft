# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/minit/minit-0.9.1.ebuild,v 1.4 2004/06/30 21:15:50 agriffis Exp $

inherit eutils

DESCRIPTION="a small yet feature-complete init"
HOMEPAGE="http://www.fefe.de/minit/"
SRC_URI="http://www.fefe.de/minit/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-libs/dietlibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-destdir.patch
}

src_compile() {
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc CHANGES README TODO
}
