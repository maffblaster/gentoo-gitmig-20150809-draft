# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libarchive/libarchive-1.02.034.ebuild,v 1.2 2005/10/09 19:46:05 flameeyes Exp $

inherit eutils libtool autotools

DESCRIPTION="Library to create and read several different archive formats."
HOMEPAGE="http://people.freebsd.org/~kientzle/libarchive/"
SRC_URI="http://people.freebsd.org/~kientzle/libarchive/src/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
IUSE=""

RDEPEND="app-arch/bzip2
	sys-libs/zlib"
DEPEND="${RDEPEND}
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Build with libtool to build shared library
	epatch ${FILESDIR}/${PN}-1.02.027-libtool.patch

	eautoreconf
	elibtoolize
	epunt_cxx
}

src_install() {
	make DESTDIR="${D}" install

	if ! use userland_Darwin; then
		dodir /$(get_libdir)
		mv ${D}/usr/$(get_libdir)/*.so* ${D}/$(get_libdir)
		gen_usr_ldscript libarchive.so
	fi
}
