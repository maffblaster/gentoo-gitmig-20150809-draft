# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/torcs/torcs-1.3.0.ebuild,v 1.4 2007/04/09 05:39:00 welp Exp $

inherit eutils multilib games

DESCRIPTION="The Open Racing Car Simulator"
HOMEPAGE="http://torcs.sourceforge.net/"
SRC_URI="mirror://sourceforge/torcs/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-libs/plib-1.8.4
	virtual/opengl
	virtual/glu
	virtual/glut
	>=media-libs/openal-0.0.8-r1
	media-libs/freealut
	media-libs/libpng
	x11-libs/libXrandr"

src_compile() {
	egamesconf \
		--disable-dependency-tracking \
		--datadir="${GAMES_DATADIR_BASE}" \
		--x-libraries=/usr/$(get_libdir) \
		--enable-xrandr \
		|| die
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install datainstall || die "emake install failed"
	newicon Ticon.png ${PN}.png
	make_desktop_entry ${PN} TORCS
	dodoc README.linux doc/history/history.txt
	doman doc/man/*.6
	dohtml -r doc/faq/faq.html doc/tutorials doc/userman
	rm -rf $(find "${D}/usr/share/doc" -type d -name CVS)
	prepgamesdirs
}
