# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/abs-guide/abs-guide-3.6.ebuild,v 1.1 2005/08/29 01:55:44 ka0ttic Exp $

DESCRIPTION="An advanced reference and a tutorial on bash shell scripting"
SRC_URI="http://personal.riverusers.com/~thegrendel/${P}.tar.bz2"
HOMEPAGE="http://www.tldp.org/LDP/abs/html"
S="${WORKDIR}"

IUSE=""
KEYWORDS="alpha amd64 hppa mips ppc sparc x86"
LICENSE="OPL"
SLOT="0"

src_install() {
	dodir /usr/share/doc/${P}       || die "dodir failed"
	cp -R * ${D}/usr/share/doc/${P} || die "cp failed"
}
