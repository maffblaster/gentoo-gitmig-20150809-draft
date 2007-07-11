# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ispell-pt/ispell-pt-20041027.ebuild,v 1.2 2007/07/11 05:41:19 mr_bones_ Exp $

S=${WORKDIR}"/portugues"
DESCRIPTION="A Portuguese dictionary for ispell"
SRC_URI="http://natura.di.uminho.pt/download/sources/Dictionaries/ispell/ispell.pt.${PV}.tar.gz"
HOMEPAGE="http://natura.di.uminho.pt"

SLOT="0"
LICENSE="GPL-2"
IUSE=""
KEYWORDS="ppc x86 sparc alpha mips hppa amd64"

DEPEND="app-text/ispell"

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/ispell
	doins portugues.aff portugues.hash

	dodoc README
}
