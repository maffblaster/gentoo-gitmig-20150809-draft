# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyalsaaudio/pyalsaaudio-0.5.ebuild,v 1.3 2009/09/17 11:26:56 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

DESCRIPTION="A Python wrapper for the ALSA API"
HOMEPAGE="http://www.sourceforge.net/projects/pyalsaaudio"
SRC_URI="mirror://sourceforge/pyalsaaudio/${P}.tar.gz"

LICENSE="PSF-2.4"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc"

RDEPEND="media-libs/alsa-lib"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/sphinx-0.6 )"

DOCS="CHANGES README"

src_compile() {
	distutils_src_compile

	if use doc; then
		cd doc
		emake html || die "emake html failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc/html/
	fi

	insinto /usr/share/doc/${PF}/examples
	doins *test.py
}
