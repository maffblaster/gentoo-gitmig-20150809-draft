# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libaal/libaal-1.0.2_pre1.ebuild,v 1.3 2004/10/01 14:35:23 blubb Exp $

inherit eutils

MY_P="${PN}-${PV/_/-}"
DATE="2004.09.17"
DESCRIPTION="library required by reiser4progs"
HOMEPAGE="http://www.namesys.com/v4/v4.html"
SRC_URI="ftp://ftp.namesys.com/pub/reiser4progs/pre/${DATE}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=""

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf \
		--enable-stand-alone \
		--enable-memory-manager \
		--libdir=/$(get_libdir) || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS CREDITS ChangeLog NEWS README THANKS TODO

	# move silly .a libs out of /
	dodir /usr/$(get_libdir)
	local l=""
	for l in libaal libaal-alone ; do
		mv ${D}/$(get_libdir)/${l}.{a,la} ${D}/usr/$(get_libdir)/
		dosym ../usr/$(get_libdir)/${l}.a /$(get_libdir)/${l}.a
		gen_usr_ldscript ${l}.so
	done
}
