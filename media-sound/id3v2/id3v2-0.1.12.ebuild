# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/id3v2/id3v2-0.1.12.ebuild,v 1.5 2011/12/18 18:17:49 armin76 Exp $

EAPI=2

inherit toolchain-funcs

DESCRIPTION="A command line editor for id3v2 tags."
HOMEPAGE="http://id3v2.sourceforge.net/"
SRC_URI="mirror://sourceforge/id3v2/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc ~ppc64 x86 ~x86-fbsd"
IUSE=""

DEPEND="media-libs/id3lib"
RDEPEND="${DEPEND}"

src_prepare() {
	emake clean || die
}

src_configure() {
	tc-export CC CXX
}

src_install() {
	dobin id3v2 || die
	doman id3v2.1 || die
	dodoc README || die
}
