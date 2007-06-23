# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libspiff/libspiff-0.7.0.ebuild,v 1.1 2007/06/23 01:17:27 beandog Exp $

DESCRIPTION="Library for XSPF playlist reading and writing"
HOMEPAGE="http://libspiff.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="LGPL-2.1 BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
RDEPEND=">=dev-libs/expat-1.95.8"
DEPEND="${RDEPEND}
	>=dev-libs/uriparser-0.3.3-r1
	doc? ( app-doc/doxygen )"

src_compile() {
	econf || die "configure failed"
	emake || die "emake failed"

	if use doc; then
		ebegin "Creating documentation"
		cd "${S}/doc"
		doxygen Doxyfile
		eend 0
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README AUTHORS ChangeLog

	if use doc; then
		dohtml doc/html/*
	fi
}
