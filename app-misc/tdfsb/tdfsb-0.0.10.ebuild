# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/tdfsb/tdfsb-0.0.10.ebuild,v 1.5 2008/11/15 13:42:37 flameeyes Exp $

IUSE=""

DESCRIPTION="SDL based graphical file browser"
HOMEPAGE="http://www.determinate.net/webdata/seg/tdfsb.html"
SRC_URI="http://www.determinate.net/webdata/data/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ppc -sparc x86"

DEPEND="media-libs/smpeg
	media-libs/sdl-image
	virtual/glut"

src_unpack() {
	unpack ${A}

	sed -i "s:-O2:${CFLAGS}:" ${S}/compile.sh
}

src_compile() {
	./compile.sh || die "compile failed"
}

src_install() {
	dobin tdfsb || die
	dodoc ChangeLog README
}
