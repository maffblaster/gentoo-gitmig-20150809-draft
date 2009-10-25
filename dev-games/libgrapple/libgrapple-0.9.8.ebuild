# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/libgrapple/libgrapple-0.9.8.ebuild,v 1.2 2009/10/25 13:11:58 maekke Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="A high level network layer for multiuser applications"
HOMEPAGE="http://grapple.linuxgamepublishing.com/"
SRC_URI="http://osfiles.linuxgamepublishing.com/${P}.tbz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="ssl"

RDEPEND="ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-build.patch
	eautoreconf
}

src_configure() {
	econf $(use_enable ssl openssl)
}

src_test() {
	test/unittest | tee "${T}"/test.log
	tail -n 1 "${T}"/test.log | grep -q " 0 fail" || die "test failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc CREDITS README* UPDATES
}
