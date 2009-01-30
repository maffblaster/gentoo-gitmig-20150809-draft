# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/psemu-spunull/psemu-spunull-1.0.ebuild,v 1.6 2009/01/30 06:55:07 mr_bones_ Exp $

EAPI=2
inherit eutils games

DESCRIPTION="PSEmu plugin to use a null sound driver"
HOMEPAGE="http://www.pcsx.net/"
SRC_URI="http://linuzappz.pcsx.net/downloads/spunull-${PV}.tgz"

LICENSE="freedist"
SLOT="0"
KEYWORDS="x86"
IUSE=""

S=${WORKDIR}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-makefile-cflags.patch
	sed -i \
		-e 's/gcc/$(CC)/' \
		src/Makefile \
		|| die "sed failed"
}

src_compile() {
	emake -C src OPTFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dodoc ReadMe.txt
	cd src
	exeinto "$(games_get_libdir)"/psemu/plugins
	doexe libspunull-* || die "doexe failed"
	prepgamesdirs
}
