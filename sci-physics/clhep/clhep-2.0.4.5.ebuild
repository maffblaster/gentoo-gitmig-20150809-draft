# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-physics/clhep/clhep-2.0.4.5.ebuild,v 1.6 2010/01/23 15:55:42 ranger Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="High Energy Physics C++ library"
HOMEPAGE="http://www.cern.ch/clhep"
SRC_URI="http://proj-clhep.web.cern.ch/proj-clhep/DISTRIBUTION/tarFiles/${P}.tgz"
LICENSE="public-domain"
SLOT="2"
KEYWORDS="amd64 hppa ppc ~sparc x86"

IUSE="exceptions"
RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PV}/CLHEP"

src_prepare() {
	for d in $(find . -name configure.in); do
		# respect user flags and fix some compilers stuff
		sed -i \
			-e 's:^g++):*g++):g' \
			-e 's:^icc):icc|icpc):g' \
			-e '/AM_CXXFLAGS=/s:-O ::g' \
			${d} || die
		# need to rebuild because original configurations
		# have buggy detection
	done
	for d in $(find . -name Makefile.am | xargs grep -l ": %\.cc"); do
		sed -i \
			-e 's|: %\.cc|: %\.cc \$(shareddir)|' \
			-e 's|all-local: \$(shareddir)|all-local: |' \
			${d} || die
		# fixing parallel build
	done
	epatch "${FILESDIR}/${P}-gcc4.3.patch"
	eautoreconf
}

src_configure() {
	econf $(use_enable exceptions)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README ChangeLog || die
}
