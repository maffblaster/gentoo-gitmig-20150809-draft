# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/slimevolley/slimevolley-2.4.2.ebuild,v 1.3 2011/01/15 14:38:38 maekke Exp $

EAPI=2
inherit cmake-utils eutils games

DESCRIPTION="A simple volleyball game"
HOMEPAGE="http://slime.tuxfamily.org/index.php"
SRC_URI="http://downloads.tuxfamily.org/slime/v242/${PN}_${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="net"

RDEPEND="media-libs/libsdl[X,audio,video]
	media-libs/sdl-ttf
	media-libs/sdl-image[png]
	net? ( media-libs/sdl-net )
	virtual/libintl"
DEPEND="${RDEPEND}
	sys-devel/gettext"

DOCS="docs/README docs/TODO"

PATCHES=( "${FILESDIR}"/${P}-nodatalocal.patch ) # bug #318005

S=${WORKDIR}/${PN}

src_configure() {
	mycmakeargs=(
	"-DCMAKE_VERBOSE_MAKEFILE=TRUE"
	"-DBIN_DIR=${GAMES_BINDIR}"
	$(use net && echo "-DNO_NET=0" || echo "-DNO_NET=1")
	)
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
	prepgamesdirs
}
