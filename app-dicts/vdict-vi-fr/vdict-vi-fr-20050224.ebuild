# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/vdict-vi-fr/vdict-vi-fr-20050224.ebuild,v 1.1 2005/02/24 08:35:50 pclouds Exp $

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
DESCRIPTION="Vdict - Dictionaries files"
SRC_URI="mirror://sourceforge/xvnkb/vi-fr.src.bz2"
HOMEPAGE="http://xvnkb.sourceforge.net/?menu=vdict&lang=en"
IUSE=""
DEPEND="app-dicts/vdict"
S=${WORKDIR}
src_compile() {
	wd2vd -s vi-fr.src -d vi-fr.vdbf -i vi-fr.vdbi -x "Vietnamese-French"
}

src_install() {
	insinto /usr/share/dict
	doins vi-fr.vdbf vi-fr.vdbi
}
pkg_postinst() {
	einfo "Please do search for dictionaries in vdict"
}
