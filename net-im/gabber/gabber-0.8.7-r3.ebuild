# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gabber/gabber-0.8.7-r3.ebuild,v 1.12 2004/04/14 09:35:57 aliz Exp $

inherit eutils

IUSE="xmms ssl nls crypt"

DESCRIPTION="The GNOME Jabber Client"
SRC_URI="mirror://sourceforge/gabber/${P}.tar.gz"
HOMEPAGE="http://gabber.sourceforge.net"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~alpha ppc"

DEPEND=">=gnome-base/gnome-libs-1.4.1.7
	>=gnome-base/libglade-0.17-r1
	<gnome-base/libglade-2.0.0
	<gnome-extra/gal-1.99
	>=dev-cpp/gnomemm-1.2.2
	>=dev-cpp/gtkmm-1.2.5
	<dev-cpp/gtkmm-1.3.0
	ssl? ( >=dev-libs/openssl-0.9.6 )
	crypt? ( >=app-crypt/gnupg-1.0.5 )
	xmms? ( >=media-sound/xmms-1.2.7-r11 )"

RDEPEND="${DEPEND} nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	# patch for minor C++ coding error. sent upstream
	# (mkennedy@gentoo.org).
	cd ${S}
	epatch ${FILESDIR}/TCPtransmitter.cc-gcc3-gentoo.patch
}

src_compile() {
	local myconf

	use ssl \
		|| myconf="${myconf} --disable-ssl"

	use nls \
		|| myconf="${myconf} --disable-nls"

	use xmms \
	        || myconf="${myconf} --disable-xmms"

	econf ${myconf} || die

	# don't fsck with the gcc systems paths! (mkennedy@gentoo.org)
	sed -e 's,-I/usr/include ,,g' Makefile >Makefile.new && \
		cp Makefile.new Makefile
	sed -e 's,-I/usr/include ,,g' src/Makefile >src/Makefile.new && \
		cp src/Makefile.new src/Makefile
	emake || die
}

src_install() {
	einstall || die
}

