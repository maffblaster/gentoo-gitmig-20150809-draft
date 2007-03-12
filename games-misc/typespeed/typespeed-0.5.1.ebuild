# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/typespeed/typespeed-0.5.1.ebuild,v 1.3 2007/03/12 15:54:32 genone Exp $

inherit eutils games

DESCRIPTION="Test your typing speed, and get your fingers CPS"
HOMEPAGE="http://tobias.eyedacor.org/typespeed/"
SRC_URI="http://tobias.eyedacor.org/typespeed/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""

DEPEND="sys-libs/ncurses"

src_unpack() {
	unpack ${A}
	cd "${S}"
	local f
	for f in words.* ; do
		touch high.${f}
	done
}

src_compile() {
	emake \
		CFLAGS="${CFLAGS} -Wall" \
		HIGHFILES="${GAMES_STATEDIR}/${PN}" \
		WORDFILES="${GAMES_DATADIR}/${PN}" \
		|| die
}

src_install() {
	dogamesbin typespeed || die "dogamesbin failed"
	dodir "${GAMES_DATADIR}/${PN}"
	cp words.* "${D}${GAMES_DATADIR}/${PN}/" || die "cp failed"
	dodoc README TODO Changes BUGS
	doman typespeed.6
	insinto "${GAMES_STATEDIR}/${PN}"
	doins high.words.* || die "doins failed"
	prepgamesdirs
	chmod g+w "${D}${GAMES_STATEDIR}"/${PN}/*
}

pkg_postrm() {
	echo
	elog "${PN} scorefiles was installed into ${GAMES_STATEDIR}/${PN}"
	elog "and haven't been removed."
	elog "To get rid of ${PN} completely, you can safely remove"
	elog "${GAMES_STATEDIR}/${PN} running:"
	elog
	elog "rm -rf ${GAMES_STATEDIR}/${PN}"
	echo
}
