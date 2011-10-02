# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/hdaps-gl/hdaps-gl-0.0.5.ebuild,v 1.3 2011/10/02 20:44:52 hanno Exp $

inherit eutils

DESCRIPTION="OpenGL visualization for HDAPS data"
HOMEPAGE="http://hdaps.sourceforge.net"
SRC_URI="mirror://sourceforge/hdaps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/opengl
	media-libs/freeglut"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-as-needed.diff" || die
}

src_compile() {
	emake CFLAGS="${CFLAGS} ${LDFLAGS}" || die "make failed"
}

src_install() {
	dobin ${PN}
}
