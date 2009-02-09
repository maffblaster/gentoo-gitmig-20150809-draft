# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tdfsb/tdfsb-0.0.10.ebuild,v 1.7 2009/02/09 17:18:06 angelos Exp $

inherit eutils toolchain-funcs

DESCRIPTION="SDL based graphical file browser"
HOMEPAGE="http://www.determinate.net/webdata/seg/tdfsb.html"
SRC_URI="http://www.determinate.net/webdata/data/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc -sparc x86"
IUSE=""

DEPEND="media-libs/smpeg
	media-libs/sdl-image
	virtual/glut"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-asneeded.patch
	sed -i -e "s:-O2:${CFLAGS} ${LDFLAGS}:" \
		-e "s:gcc:$(tc-getCC):" "${S}"/compile.sh
}

src_compile() {
	./compile.sh || die "compile failed"
}

src_install() {
	dobin tdfsb || die
	dodoc ChangeLog README
}
