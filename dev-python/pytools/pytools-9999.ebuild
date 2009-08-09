# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pytools/pytools-9999.ebuild,v 1.1 2009/08/09 08:39:11 spock Exp $
# Ebuild generated by g-pypi 0.2.1 (rev. 204)

inherit git distutils

EGIT_REPO_URI="http://git.tiker.net/trees/pytools.git"

DESCRIPTION="A collection of tools missing from the Python standard library"
HOMEPAGE="http://mathema.tician.de/software/pytools"

SRC_URI=""
LICENSE="MIT"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="dev-python/setuptools"
RDEPEND=""

src_unpack() {
	git_src_unpack
}
