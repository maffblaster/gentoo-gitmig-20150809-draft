# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/jfbterm/jfbterm-0.4.7-r1.ebuild,v 1.5 2005/06/17 20:49:15 hansmi Exp $

inherit flag-o-matic eutils

DESCRIPTION="The J Framebuffer Terminal/Multilingual Enhancement with UTF-8 support"
HOMEPAGE="http://jfbterm.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/${PN}/13501/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=sys-apps/sed-4
	>=sys-devel/autoconf-2.58
	sys-devel/automake
	sys-devel/libtool
	sys-libs/ncurses"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-sigchld-debian.patch
}

src_compile() {
	replace-flags -march=pentium3 -mcpu=pentium3

	export WANT_AUTOCONF=2.5
	libtoolize --copy --force || die
	econf || die "econf failed"
	# jfbterm peculiarly needs to be compiled twice.
	emake -j1 || die "make failed"
	emake -j1 || die "make failed"
	sed -i -e 's/a18/8x16/' jfbterm.conf.sample
}

src_install() {
	dodir /etc /usr/share/fonts/jfbterm
	make DESTDIR=${D} install || die

	dodir /usr/share/terminfo
	tic terminfo.jfbterm -o${D}/usr/share/terminfo || die

	mv ${D}/etc/jfbterm.conf{.sample,}

	doman jfbterm.1 jfbterm.conf.5

	dodoc AUTHORS ChangeLog INSTALL* NEWS README*
	dodoc jfbterm.conf.sample*
}
