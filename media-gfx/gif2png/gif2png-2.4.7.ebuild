# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gif2png/gif2png-2.4.7.ebuild,v 1.7 2004/10/04 23:29:20 pvdabeel Exp $

DESCRIPTION="gif2png"
SRC_URI="http://catb.org/~esr/${PN}/${P}.tar.gz"
HOMEPAGE="http://catb.org/~esr/gif2png/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="media-libs/libpng"

src_compile() {
	econf --prefix=/usr || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir ${D}/usr/bin
	make \
		DESTDIR=${D} \
		install || die "make install failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README
}
