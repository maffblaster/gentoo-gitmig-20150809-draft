# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/ascii-invaders/ascii-invaders-0.1b.ebuild,v 1.15 2005/06/07 04:03:21 redhatter Exp $

inherit games

DESCRIPTION="Space invaders clone, using ncurses library"
HOMEPAGE="http://www.ip9.org/munro/invaders/"
SRC_URI="http://www.ip9.org/munro/invaders/invaders${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86 ~mips"
IUSE=""

DEPEND="sys-libs/ncurses"

S="${WORKDIR}/invaders"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e 's/-lcurses/-lncurses/g' Makefile \
		|| die "sed Makefile failed"
}

src_install() {
	dogamesbin ascii_invaders || die "dogamesbin failed"
	dodoc TODO
	prepgamesdirs
}
