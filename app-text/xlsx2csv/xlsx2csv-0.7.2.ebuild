# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xlsx2csv/xlsx2csv-0.7.2.ebuild,v 1.1 2015/06/18 04:31:50 radhermit Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_3,3_4} )
PYTHON_REQ_USE="xml"

inherit distutils-r1

DESCRIPTION="Convert MS Office xlsx files to CSV"
HOMEPAGE="https://github.com/dilshod/xlsx2csv/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-lang/perl"

python_compile_all() {
	emake -C man
}

python_install_all() {
	distutils-r1_python_install_all
	doman man/${PN}.1
}
