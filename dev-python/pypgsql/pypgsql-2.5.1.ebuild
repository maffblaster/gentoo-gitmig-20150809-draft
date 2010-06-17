# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pypgsql/pypgsql-2.5.1.ebuild,v 1.5 2010/06/17 18:32:11 patrick Exp $

inherit distutils

MY_P="pyPgSQL-${PV}"

DESCRIPTION="Python Interface to PostgreSQL"
HOMEPAGE="http://pypgsql.sourceforge.net/"
SRC_URI="mirror://sourceforge/pypgsql/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 x86"
IUSE=""

DEPEND="dev-db/postgresql-base"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="pyPgSQL"

src_install() {
	DOCS="Announce"
	distutils_src_install

	insinto /usr/share/doc/${PF}
	doins -r examples
}
