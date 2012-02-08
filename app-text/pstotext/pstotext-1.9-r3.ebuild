# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/pstotext/pstotext-1.9-r3.ebuild,v 1.3 2012/02/08 20:11:18 jer Exp $

EAPI="3"

inherit eutils toolchain-funcs

DESCRIPTION="Extract ASCII text from a PostScript or PDF file"
HOMEPAGE="http://www.cs.wisc.edu/~ghost/doc/pstotext.htm"
SRC_URI="ftp://mirror.cs.wisc.edu/pub/mirrors/ghost/contrib/${P}.tar.gz"

LICENSE="PSTT"
SLOT="0"
KEYWORDS="amd64 hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="app-arch/ncompress"
RDEPEND="app-text/ghostscript-gpl"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-quote-chars-fix.patch \
		"${FILESDIR}"/${PV}-flags.patch
	tc-export CC
}

src_install () {
	dobin pstotext || die
	doman pstotext.1 || die
}
