# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/realpath/realpath-1.9.3.ebuild,v 1.10 2005/01/01 11:23:10 eradicator Exp $

DESCRIPTION="Return the canonicalized absolute pathname"
HOMEPAGE="http://packages.debian.org/unstable/utils/realpath.html"
SRC_URI="mirror://debian/pool/main/d/dwww/dwww_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc ~sparc ~mips amd64"
IUSE=""

S=${WORKDIR}/dwww-${PV}

src_compile() {
	make LIBS='' VERSION=$PV realpath || die
}

src_install() {
	dobin realpath || die
	doman man/realpath.1
	dodoc README TODO
}
