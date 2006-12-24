# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/yabause/yabause-0.8.0.ebuild,v 1.1 2006/12/24 10:12:50 nyhm Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=latest
inherit autotools eutils games

DESCRIPTION="A Sega Saturn emulator"
HOMEPAGE="http://yabause.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

RDEPEND="=x11-libs/gtk+-2*
	x11-libs/gtkglext
	virtual/opengl
	virtual/glu
	virtual/glut
	media-libs/libsdl"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i '/DATA/d' src/gtk/Makefile.am || die "sed failed"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	make_desktop_entry ${PN} Yabause
	doicon src/gtk/${PN}.png
	dodoc AUTHORS ChangeLog GOALS TODO README README.LIN
	prepgamesdirs
}
