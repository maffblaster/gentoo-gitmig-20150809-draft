# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2003-bonuspack-de/ut2003-bonuspack-de-1.ebuild,v 1.4 2004/07/03 02:22:45 mr_bones_ Exp $

inherit games

MY_P="debonus.ut2mod.zip"
DESCRIPTION="Digital Extremes Bonus Pack for UT2003"
HOMEPAGE="http://www.unrealtournament2003.com/"
SRC_URI="mirror://3dgamers/pub/3dgamers5/games/unrealtourn2/Missions/${MY_P}
	mirror://3dgamers/pub/3dgamers/games/unrealtourn2/Missions/${MY_P}
	http://www.unixforces.net/downloads/${MY_P}"

LICENSE="ut2003"
SLOT="1"
KEYWORDS="x86"
IUSE=""
RESTRICT="nostrip nomirror"

DEPEND="app-arch/unzip"
RDEPEND="games-fps/ut2003"

S="${WORKDIR}"

dir="${GAMES_PREFIX_OPT}/ut2003"
Ddir="${D}/${dir}"

src_unpack() {
	unzip ${DISTDIR}/${A} || die "unpacking"
}

src_install() {
	mkdir -p ${Ddir}/{System,Maps,StaticMeshes,Textures,Music,Help}
	games_umod_unpack DEBonus.ut2mod
	prepgamesdirs
}
