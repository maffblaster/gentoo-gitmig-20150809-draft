# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pstoedit/pstoedit-3.33.ebuild,v 1.7 2004/02/16 10:46:57 obz Exp $

inherit libtool

# see bug #29724. please don't re-enable flash support until
# ming has the patches applied <obz@gentoo.org>
# secondly, we're not enabling libemf via a use flag, until it's
# actually switchable via configure, see bug #39557
# IUSE="flash libemf"
IUSE=""

DESCRIPTION="translates PostScript and PDF graphics into other vector formats"
SRC_URI="http://home.t-online.de/home/helga.glunz/wglunz/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.pstoedit.net/pstoedit"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

DEPEND="sys-libs/zlib
	media-libs/libemf
	media-libs/libpng
	media-libs/libexif"
#	flash? ( media-libs/ming )"

RDEPEND="${DEPEND}
	virtual/ghostscript"

src_unpack() {

	unpack ${A}; cd ${S}
	# need to remove the pedantic flag, see bug #39557
	sed -i -e "s/\-pedantic//" configure

}

src_compile() {

	local myconf=""
	# checking if libemf is previously installed, bug #29724
	[ -f /usr/include/libEMF/emf.h ] \
		&& myconf="${myconf} --with-libemf-include=/usr/include/libEMF"

	elibtoolize
	econf ${myconf}
	make || die

}

src_install () {

	make DESTDIR=${D} install || die "make install failed"
	dodoc readme.txt copying
	dohtml changelog.htm index.htm doc/pstoedit.htm
	doman doc/pstoedit.1

}
