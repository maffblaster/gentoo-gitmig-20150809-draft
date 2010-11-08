# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/exact-image/exact-image-0.8.1.ebuild,v 1.3 2010/11/08 22:36:11 maekke Exp $

EAPI=2

PYTHON_DEPEND="python? 2:2.5"

inherit eutils multilib python

DESCRIPTION="A fast, modern and generic image processing library"
HOMEPAGE="http://www.exactcode.de/site/open_source/exactimage/"
SRC_URI="http://dl.exactcode.de/oss/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="expat jpeg jpeg2k lcms lua openexr php perl png python ruby swig tiff truetype X"

RDEPEND="x11-libs/agg[truetype]
	sys-libs/zlib
	expat? ( dev-libs/expat )
	jpeg2k? ( media-libs/jasper )
	jpeg? ( virtual/jpeg )
	lcms? ( =media-libs/lcms-1* )
	lua? ( dev-lang/lua )
	openexr? ( media-libs/openexr )
	php? ( dev-lang/php )
	perl? ( sys-devel/libperl )
	png? ( >=media-libs/libpng-1.2.43 )
	ruby? ( dev-lang/ruby )
	tiff? ( media-libs/tiff )
	truetype? ( >=media-libs/freetype-2 )
	X? (
		x11-libs/libXext
		x11-libs/libXt
		x11-libs/libICE
		x11-libs/libSM
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	swig? ( dev-lang/swig )"

pkg_setup() {
	if use python; then
		python_set_active_version 2
	fi
}

src_prepare() {
	python_convert_shebangs -r 2 .
	epatch "${FILESDIR}"/${PN}-0.7.5-libpng14.patch
	# fix python hardcoded path wrt bug #327171
	sed -i -e "s:python2.5:python$(python_get_version):" \
		-e "s:\$(libdir):usr/$(get_libdir):" \
		"${S}"/api/python/Makefile
}

src_configure() {
	# evas -> enlightenment overlay
	# bardecode -> protected by custom license
	# libungif -> not supported anymore

	./configure \
		--prefix=/usr \
		--libdir=/usr/$(get_libdir) \
		$(use_with X x11) \
		$(use_with truetype freetype) \
		--without-evas \
		$(use_with jpeg libjpeg) \
		$(use_with tiff libtiff) \
		$(use_with png libpng) \
		--without-libungif \
		$(use_with jpeg2k jasper) \
		$(use_with openexr) \
		$(use_with expat) \
		$(use_with lcms) \
		--without-bardecode \
		$(use_with lua) \
		$(use_with swig) \
		$(use_with perl) \
		$(use_with python) \
		$(use_with php) \
		$(use_with ruby) || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README TODO || die
}
