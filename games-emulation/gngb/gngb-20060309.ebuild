# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gngb/gngb-20060309.ebuild,v 1.7 2010/10/28 12:46:57 tupone Exp $

EAPI=2
inherit eutils games

DESCRIPTION="Gameboy / Gameboy Color emulator"
HOMEPAGE="http://m.peponas.free.fr/gngb/"
SRC_URI="http://m.peponas.free.fr/gngb/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="opengl"

RDEPEND="media-libs/libsdl[audio,joystick,video]
	sys-libs/zlib
	app-arch/bzip2
	opengl? ( virtual/opengl )"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}"/${P}-ovflfix.patch )

src_configure() {
	egamesconf $(use_with opengl gl)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO
	prepgamesdirs
}
