# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2  
# $Header: /var/cvsroot/gentoo-x86/net-mail/balsa/balsa-1.4.0-r1.ebuild,v 1.4 2002/10/05 05:39:22 drobbins Exp $

IUSE="ssl nls cups gtkhtml the spell perl"

S=${WORKDIR}/${P}
DESCRIPTION="Balsa: email client for GNOME"
SRC_URI="http://www.theochem.kth.se/~pawsa/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.balsa.net"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=dev-libs/glib-1.2*
	=x11-libs/gtk+-1.2*
	>=media-libs/imlib-1.9.10-r1
	>=gnome-base/gnome-libs-1.4.1.4
	>=gnome-base/ORBit-0.5.10-r1
	>=media-libs/gdk-pixbuf-0.13.0
	>=net-libs/libesmtp-0.8.11
	nls? ( sys-devel/gettext )
	ssl? ( dev-libs/openssl )
	cups? ( >=gnome-base/gnome-print-0.30 )
	perl? ( >=dev-libs/libpcre-3.4 )
	spell? ( >=app-text/aspell-0.50 )
	gtkhtml? ( >=gnome-extra/gtkhtml-0.16.1 )"

src_unpack() {
	unpack ${A}

	Patch to use the new aspell instead of the old, crusty pspell modules
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff || die

}

src_compile() {
	local myconf

	use nls || myconf="${myconf} --disable-nls"
	use ssl && myconf="${myconf} --with-ssl"
	use gtkhtml && myconf="${myconf} --with-gtkhtml"
	use perl && myconf="${myconf} --enable-pcre"
	use spell && myconf="${myconf} --with-aspell=yes"

	myconf="${myconf} --with-mailpath=/var/mail --enable-threads"

	autoconf || die
	econf ${myconf} || die "configure balsa failed"
	emake || die "emake failed"
}


src_install () {
	local myinst
	myinst="gnomeconfdir=${D}/etc \
		gnomedatadir=${D}/usr/share"

	einstall ${myinst} || die "make install failed"
	dodoc AUTHORS COPYING ChangeLog HACKING INSTALL NEWS README TODO
	docinto docs
	dodoc docs/*
}
