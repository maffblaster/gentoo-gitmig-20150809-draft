# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/hugin/hugin-0.8.0_beta1.ebuild,v 1.1 2009/02/25 07:11:24 maekke Exp $

EAPI="2"
WX_GTK_VER="2.8"

inherit cmake-utils eutils wxwidgets versionator

DESCRIPTION="GUI for the creation & processing of panoramic images"
HOMEPAGE="http://hugin.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2 SIFT"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+sift"

DEPEND="
	app-arch/zip
	|| ( >=dev-libs/boost-1.34 =dev-libs/boost-1.33*[threads] )
	>=media-gfx/enblend-3.0_p20080807
	media-gfx/exiv2
	media-libs/jpeg
	media-libs/libpano13
	media-libs/libpng
	media-libs/openexr
	media-libs/tiff
	sys-libs/zlib
	x11-libs/wxGTK:2.8
	sift? ( media-gfx/autopano-sift-C )"
RDEPEND="${DEPEND}"

DOCS="AUTHORS README TODO"
S="${WORKDIR}/${PN}-$(get_version_component_range 1-3)"

src_prepare() {
	epatch "${FILESDIR}"/${P}-as-needed.patch
}
