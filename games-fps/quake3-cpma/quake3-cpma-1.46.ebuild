# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/quake3-cpma/quake3-cpma-1.46.ebuild,v 1.3 2009/10/07 01:34:54 nyhm Exp $

EAPI=2

MOD_DESC="advanced FPS competition mod"
MOD_NAME="Challenge Pro Mode Arena"
MOD_DIR="cpma"

inherit games games-mods

HOMEPAGE="http://www.promode.org/"
SRC_URI="http://www.challenge-tv.com/demostorage/files/cpm/cpma${PV//.}-nomaps.zip
	http://ftp1.srv.endpoint.nu/pub/repository/challenge-tv/demostorage/files/cpm/cpma${PV//.}-nomaps.zip
	http://www.promode.org/files/cpma-mappack-full.zip"

LICENSE="as-is"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="dedicated opengl"

src_prepare() {
	mv -f *.pk3 ${MOD_DIR} || die
}

pkg_postinst() {
	games-mods_pkg_postinst
	elog "To enable bots: +bot_enable 1"
}
