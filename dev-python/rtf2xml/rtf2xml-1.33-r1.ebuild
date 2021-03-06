# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/rtf2xml/rtf2xml-1.33-r1.ebuild,v 1.1 2015/01/07 04:18:09 idella4 Exp $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Converts a Microsoft RTF file to structured XML"
HOMEPAGE="http://rtf2xml.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=""
RDEPEND=""

python_install_all() {
	use doc && local HTML_DOCS=( docs/html/. )
	distutils-r1_python_install_all
}
