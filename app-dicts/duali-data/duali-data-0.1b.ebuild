# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/duali-data/duali-data-0.1b.ebuild,v 1.5 2004/06/06 23:54:00 dragonheart Exp $

IUSE="X gnome"

DESCRIPTION="Dictionary data for the Arab dictionary project duali"
HOMEPAGE="http://www.arabeyes.org/project.php?proj=Duali"
SRC_URI="mirror://sourceforge/arabeyes/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ia64 ~ppc ~sparc alpha ~hppa ~mips"

DEPEND="app-text/duali"

src_compile() {
	dict2db --path ./ || die
}

src_install() {
	insinto /usr/share/duali
	doins stems.db prefixes.db suffixes.db
	doins tableab tableac tablebc

	dodoc gpl.txt README
}
