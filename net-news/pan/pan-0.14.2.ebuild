# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/pan/pan-0.14.2.ebuild,v 1.6 2004/03/10 15:08:19 gustavoz Exp $

IUSE="spell"

DESCRIPTION="A newsreader for the Gnome2 desktop"
SRC_URI="http://pan.rebelbase.com/download/releases/${PV}/SOURCE/${P}.tar.bz2"
HOMEPAGE="http://pan.rebelbase.com"

LICENSE="GPL-2"
KEYWORDS="x86 ~hppa ~ppc sparc amd64"
SLOT="0"

RDEPEND=">=dev-libs/glib-2.0.4
	>=x11-libs/gtk+-2.0.5
	>=dev-libs/libxml2-2.4.22
	>=net-libs/gnet-1.1.8
	spell? ( >=app-text/gtkspell-2.0.2 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.21
	sys-devel/gettext"

export CONFIG_PROTECT_MASK="/etc/gconf"

src_compile() {
	local myconf=""

	# Likely that glibc might of been compiled with nls turned off.
	# Warn people that Pan requires glibc to have nls support.
	if [ -z "`use nls`" ]; then
		ewarn "Pan requires glibc to be merged with 'nls' in your USE flags."
	fi

	use spell \
		&& myconf="${myconf} --enable-gtkspell" \
		|| myconf="${myconf} --disable-gtkspell"
	cd ${S} && libtoolize -c -f
	econf ${myconf} || die "Configure failure"

	emake || die "Compilation failure"
}

src_install() {
	einstall || die "Installation failed"
	dodoc ANNOUNCE AUTHORS ChangeLog COPYING CREDITS INSTALL NEWS README TODO
}
