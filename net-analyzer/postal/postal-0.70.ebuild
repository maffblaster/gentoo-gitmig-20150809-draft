# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/postal/postal-0.70.ebuild,v 1.1 2008/06/15 12:23:26 dertobi123 Exp $

inherit autotools eutils

DESCRIPTION="SMTP and POP mailserver benchmark. Supports SSL, randomized user accounts and more."
HOMEPAGE="http://www.coker.com.au/postal/"
SRC_URI="http://www.coker.com.au/postal/${P}.tgz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="ssl gnutls"
#ssl is an alias for openssl. If both ssl and gnutls are enabled, automagic will
#enable only gnutls.
DEPEND="ssl? (
	!gnutls? ( >=dev-libs/openssl-0.9.8g )
	gnutls? ( >=net-libs/gnutls-2.2.2 )
	)"

pkg_setup() {
	myconf=" --disable-stripping
		$(use_enable ssl openssl)
		$(use_enable gnutls gnutls)"

}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/01_${P}-gcc43.patch"
	epatch "${FILESDIR}/02_${P}-nossl.patch"
	epatch "${FILESDIR}/03_${P}-c++0x-integrated.patch"
	epatch "${FILESDIR}/04_${P}-warnings.patch"
	eautoreconf
}

src_compile() {
	econf ${myconf} || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

}
