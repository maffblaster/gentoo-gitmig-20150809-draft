# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openvpn/openvpn-1.5.0.ebuild,v 1.6 2004/08/25 02:52:16 swegener Exp $

IUSE="ssl"

DESCRIPTION="OpenVPN is a robust and highly flexible tunneling application compatible with many OSes."
SRC_URI="mirror://sourceforge/openvpn/${P}.tar.gz"
HOMEPAGE="http://openvpn.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND=">=dev-libs/lzo-1.07
	virtual/os-headers
	ssl? ( >=dev-libs/openssl-0.9.6 )"

src_compile() {

	local myconf

	use ssl || myconf='--disable-ssl --disable-crypto'

	econf || die
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc COPYING CHANGES INSTALL PORTS README
	exeinto /etc/init.d
	doexe ${FILESDIR}/openvpn
}


pkg_postinst() {
	einfo "The init.d script that comes with OpenVPN expects directories /etc/openvpn/*/ with a local.conf and any supporting files, such as keys."
	ewarn "This version of OpenVPN is NOT COMPATIBLE with 1.4.2!"
	ewarn "If you need compatibility with 1.4.2 please emerge that version."
}
