# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/viking/viking-0.9.8.ebuild,v 1.1 2009/02/13 21:59:01 hanno Exp $

DESCRIPTION="Viking is a program to manage GPS data."
HOMEPAGE="http://viking.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
IUSE="gps"
KEYWORDS="~amd64 ~x86"
MAKEOPTS="${MAKEOPTS} -j1"

RDEPEND=">=x11-libs/gtk+-2.2.0
	gps? ( sci-geosciences/gpsd )
	net-misc/curl
	sci-geosciences/gpsbabel"
DEPEND=">=x11-libs/gtk+-2.2.0
	gps? ( sci-geosciences/gpsd )
	dev-util/intltool
	dev-util/pkgconfig"

src_compile() {
	econf --enable-openstreetmap \
		--enable-expedia \
		--enable-terraserver \
		--enable-google \
		$(use_enable gps realtime-gps-tracking) \
		|| die "configure failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc README doc/GEOCODED-PHOTOS doc/GETTING-STARTED doc/GPSMAPPER \
		|| die "Unable to install docs"
}
