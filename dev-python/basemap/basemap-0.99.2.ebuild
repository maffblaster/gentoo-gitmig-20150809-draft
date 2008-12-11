# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/basemap/basemap-0.99.2.ebuild,v 1.1 2008/12/11 19:30:34 bicatali Exp $

inherit eutils distutils

DESCRIPTION="matplotlib toolkit to plot map projections"
HOMEPAGE="http://matplotlib.sourceforge.net/matplotlib.toolkits.basemap.basemap.html"
SRC_URI="mirror://sourceforge/matplotlib/${P}.tar.gz"

IUSE="examples"
SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="MIT GPL-2"

CDEPEND="sci-libs/shapelib
	>=dev-python/matplotlib-0.98
	>=sci-libs/geos-2.2.3"

DEPEND="${CDEPEND}
	dev-python/setuptools"

RDEPEND="${CDEPEND}
	dev-python/pupynere
	dev-python/dap"

DOCS="FAQ API_CHANGES"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# patch to use shapelib and geos system libraries
	# proj is unfortunately an internal patched version (bug #209895)
	epatch "${FILESDIR}"/${PN}-0.99.2-syslib.patch
	rm -f lib/mpl_toolkits/basemap/pupynere.py || die
}

src_test() {
	cd build/lib*
	PYTHONPATH=. python mpl_toolkits/basemap/test.py || die
}

src_install() {
	distutils_src_install --install-data=/usr/share/${PN}
	rm -f "${D}"/usr/lib*/python*/site-packages/mpl_toolkits/__init__.py
	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r examples || die
	fi
}
