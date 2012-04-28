# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/SchemaSync/SchemaSync-0.9.2.ebuild,v 1.1 2012/04/28 00:22:41 blueness Exp $

EAPI="4"

PYTHON_DEPEND="2:2.5:2.6"

inherit distutils

DESCRIPTION="MySQL Schema Versioning and Migration Utility"
HOMEPAGE="http://schemasync.org/"
SRC_URI="http://www.schemasync.org/downloads/${P}.tar.gz"

pn="${PN,,}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	dev-python/mysql-python
	dev-python/SchemaObject"
DEPEND="${RDEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 2 .
}

pkg_postinst() {
	python_mod_optimize "${pn}"
}

pkg_postrm() {
	python_mod_cleanup "${pn}"
}
