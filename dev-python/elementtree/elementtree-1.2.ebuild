# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/elementtree/elementtree-1.2.ebuild,v 1.1 2004/06/24 23:00:30 lucass Exp $

inherit distutils

MY_P="${PN}-${PV}-20040618"
DESCRIPTION="A light-weight XML object model for Python"
HOMEPAGE="http://effbot.org/zone/element-index.htm"
SRC_URI="http://effbot.org/downloads/${MY_P}.zip"
KEYWORDS="~x86 ~ppc"
DEPEND="virtual/python"
RDEPEND="${DEPEND}
	app-arch/unzip"
LICENSE="as-is"
SLOT="0"
IUSE=""
S=${WORKDIR}/${MY_P}

src_install() {
	distutils_src_install

	dodoc CHANGES
	dohtml docs/*
}
