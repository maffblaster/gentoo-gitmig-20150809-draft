# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/opengtl/opengtl-0.9.15.1.ebuild,v 1.1 2011/07/22 15:09:07 dilfridge Exp $

EAPI=4

MY_P="OpenGTL-${PV}"

inherit cmake-utils

DESCRIPTION="Collection of libraries for graphics transformation algorithms"
HOMEPAGE="http://opengtl.org/"
SRC_URI="http://download.opengtl.org/${MY_P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug test"

RDEPEND="
	media-libs/libpng
	>=sys-devel/llvm-2.7
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	test? ( dev-util/lcov )
"

S=${WORKDIR}/${MY_P}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use debug OPENGTL_ENABLE_DEBUG_OUTPUT)
		$(cmake-utils_use test OPENGTL_BUILD_TESTS)
		$(cmake-utils_use test OPENGTL_CODE_COVERAGE)
	)
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	newdoc OpenShiva/doc/reference/region.pdf OpenShiva.pdf
}
