# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xchm/xchm-0.9.4.ebuild,v 1.2 2004/10/30 22:08:07 mholzer Exp $

DESCRIPTION="Utility for viewing Microsoft .chm files."
HOMEPAGE="http://xchm.sf.net"
SRC_URI="mirror://sourceforge/xchm/${P}.tar.gz
	doc? ( mirror://sourceforge/xchm/${P}-doc.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"

IUSE="doc"
DEPEND=">=app-doc/chmlib-0.31
	>=x11-libs/wxGTK-2.4.0"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	einstall || die
	dodoc COPYING AUTHORS README

	if use doc; then
	cd ${S}"-doc"
	dohtml html/*
	fi
}
