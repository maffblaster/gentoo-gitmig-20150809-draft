# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/grib_api/grib_api-1.9.9.ebuild,v 1.3 2011/12/21 07:55:03 jlec Exp $

EAPI=3
inherit eutils autotools

#MYP=${P}_libtool
MYP=${P}

DESCRIPTION="Library for decoding WMO FM-92 GRIB messages"
HOMEPAGE="http://www.ecmwf.int/products/data/software/grib_api.html"
SRC_URI="http://www.ecmwf.int/products/data/software/download/software_files/${MYP}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc examples fortran jpeg2k netcdf openmp png perl python static-libs"

DEPEND="jpeg2k? ( || ( media-libs/jasper media-libs/openjpeg ) )
	netcdf? ( sci-libs/netcdf )
	png? ( media-libs/libpng )
	python? ( dev-python/numpy )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MYP}"

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-ieeefloat.patch \
		"${FILESDIR}"/${P}-autotools.patch
	sed \
		-e '/LDFLAGS=/d' \
		-i configure.ac || die
	eautoreconf
}

src_configure() {
	local myconf
	if use jpeg2k; then
		myconf="--enable-jpeg"
		if hasv media-libs/jasper; then
			myconf="${myconf} --with-jasper=system --without-openjpeg"
		elif hasv media-libs/openjpeg; then
			myconf="${myconf} --without-jasper --with-openjpeg=system"
		fi
	else
		myconf="--disable-jpeg --without-jasper --without-openjpeg"
	fi
	econf \
		--enable-install-system-perl \
		--with-perl-options="INSTALLDIRS=vendor" \
		$(use_enable fortran) \
		$(use_enable openmp omp-packing) \
		$(use_enable python) \
		$(use_enable python numpy) \
		$(use_enable static-libs static) \
		$(use_with netcdf netcdf "${EPREFIX}"/usr) \
		$(use_with perl) \
		$(use_with png png-support) \
		${myconf}
}

src_install() {
	emake DESTDIR="${D}" install  || die "emake install failed"
	dodoc AUTHORS ChangeLog README
	if use doc; then
		dohtml html/* || die
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		emake clean
		doins -r * || die
	fi
}
