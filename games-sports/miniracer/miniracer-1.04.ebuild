# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/miniracer/miniracer-1.04.ebuild,v 1.6 2010/02/27 21:04:12 tupone Exp $
EAPI=2

inherit eutils games

DESCRIPTION="an OpenGL car racing game, based on ID's famous Quake engine"
HOMEPAGE="http://miniracer.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="virtual/opengl
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXxf86dga
	x11-libs/libXxf86vm
	media-libs/libsdl
	media-libs/sdl-mixer"
DEPEND="${RDEPEND}
	x11-proto/xf86dgaproto
	x11-proto/xf86vidmodeproto
	x11-proto/xproto"

src_prepare() {
	epatch "${FILESDIR}"/${P}-nosharedelf.patch
	sed -i \
		-e '/^CC=/d' \
		-e "s:\$(DESTDIR)/usr/bin:\$(DESTDIR)${GAMES_BINDIR}:" \
		-e "/INCLUDES/s:-I/usr/include/SDL:$(sdl-config --cflags):" \
		-e "/CFLAGS/s:-O3 -march=i486 -ffast-math -fexpensive-optimizations:${CFLAGS}:" \
		-e "/LDFLAGS/s:-lSDL -lSDL_mixer -lpthread:$(sdl-config --libs) -lSDL_mixer:" \
		Makefile \
		|| die "sed failed"
	sed -i \
		-e "s:@GAMES_LIBDIR@:$(games_get_libdir)/${PN}:" \
		miniracer \
		Makefile \
		|| die "2nd sed failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc TODO README ChangeLog
	prepgamesdirs
}
