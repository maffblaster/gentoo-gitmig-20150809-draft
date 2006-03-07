# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kinterbasdb/kinterbasdb-3.1.3.ebuild,v 1.1 2006/03/07 23:34:36 carlo Exp $

inherit distutils

DESCRIPTION="kinterbasdb - firebird/interbase interface for Python."
HOMEPAGE="http://kinterbasdb.sourceforge.net"
SRC_URI="mirror://sourceforge/kinterbasdb/${P}.src.tar.gz"


IUSE=""
KEYWORDS="~x86 -sparc"
LICENSE="kinterbasdb"
SLOT="0"

DEPEND="virtual/python
	>=dev-db/firebird-1.0_rc1
	>=dev-python/egenix-mx-base-2.0.1"

DOCS="docs/*.txt"

src_install() {
	distutils_src_install --install-data=${D}/usr/share/doc/${PF}

	# we put docs in properly ourselves
	rm -rf ${D}/var
	dohtml docs/*
}
