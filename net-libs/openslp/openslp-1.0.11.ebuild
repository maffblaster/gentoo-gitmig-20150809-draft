# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/openslp/openslp-1.0.11.ebuild,v 1.9 2004/02/28 00:57:58 kumba Exp $

inherit gnuconfig

IUSE=""

DESCRIPTION="An open-source implementation of Service Location Protocol"
HOMEPAGE="http://www.openslp.org"
SRC_URI="mirror://sourceforge/openslp/${P}.tar.gz"

KEYWORDS="ia64 x86 sparc ppc hppa amd64 alpha ~mips"
DEPEND="virtual/glibc"
SLOT="0"
LICENSE="BSD"

src_unpack() {
	unpack ${A}

	# needed at least by alpha and amd64
	gnuconfig_update
}

src_compile() {
	econf || die
	make || die
}

src_install() {
	einstall || die
	dodoc AUTHORS FAQ COPYING ChangeLog NEWS README* THANKS
	rm -rf ${D}/usr/doc
	dohtml -r .
	exeinto /etc/init.d
	newexe ${FILESDIR}/slpd-init slpd
}
