# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/gauche-cdb/gauche-cdb-0.3.1.ebuild,v 1.7 2007/01/10 17:13:34 hkbst Exp $

inherit eutils

IUSE=""

MY_P="${P/g/G}"

DESCRIPTION="CDB binding for Gauche"
HOMEPAGE="http://sourceforge.jp/projects/gauche/"
SRC_URI="mirror://sourceforge.jp/gauche/8407/${MY_P}.tar.gz"

LICENSE="BSD"
KEYWORDS="ia64 x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND=">=dev-scheme/gauche-0.7.4
	dev-db/tinycdb"

src_unpack() {

	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-tinycdb.diff

	if has_version '>=dev-scheme/gauche-0.8'; then
		epatch ${FILESDIR}/${P}-gpd.diff
	fi

	aclocal
	autoconf

}

src_install() {

	make DESTDIR=${D} install || die
	dodoc README

	if has_version '>=dev-scheme/gauche-0.8'; then
		insinto $(gauche-config --sitelibdir)/.packages
		doins ${MY_P%-*}.gpd
	fi

}
