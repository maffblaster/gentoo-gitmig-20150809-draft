# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/gottet/gottet-1.0.3.ebuild,v 1.3 2012/04/20 08:00:16 johu Exp $

EAPI=2
inherit eutils qt4-r2 games

DESCRIPTION="A tetris clone based on Qt4"
HOMEPAGE="http://gottcode.org/gottet/"
SRC_URI="http://gottcode.org/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="x11-libs/qt-core:4
	x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

src_configure() {
	eqmake4
}

src_install() {
	dogamesbin ${PN} || die
	dodoc ChangeLog README
	doicon icons/${PN}.png
	domenu icons/${PN}.desktop
	prepgamesdirs
}
