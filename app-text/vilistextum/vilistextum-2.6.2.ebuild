# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/vilistextum/vilistextum-2.6.2.ebuild,v 1.7 2002/12/09 04:17:45 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Vilistextum is a html to ascii converter specifically programmed to get the best out of incorrect html."
SRC_URI="http://www.mysunrise.ch/users/bhaak/vilistextum/${P}.tar.bz2"
HOMEPAGE="http://www.mysunrise.ch/users/bhaak/vilistextum/"
KEYWORDS="x86 sparc "
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc"

src_compile() {
	econf --enable-multibyte || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc README README.multibyte README.xhtml CHANGES
}
