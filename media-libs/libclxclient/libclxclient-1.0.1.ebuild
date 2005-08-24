# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libclxclient/libclxclient-1.0.1.ebuild,v 1.4 2005/08/24 16:01:23 flameeyes Exp $

IUSE=""

inherit eutils

S="${WORKDIR}/clxclient-${PV}"

DESCRIPTION="An audio library by Fons Adriaensen <fons.adriaensen@skynet.be>"
HOMEPAGE="http://users.skynet.be/solaris/linuxaudio"
SRC_URI="http://users.skynet.be/solaris/linuxaudio/downloads/clxclient-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"

DEPEND="virtual/libc
	virtual/x11
	>=media-libs/libclthreads-1.0.1"

src_compile() {
	epatch "${FILESDIR}/${P}-makefile.patch"
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
}
