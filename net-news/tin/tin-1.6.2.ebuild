# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Michael Conrad Tilstra <tadpol@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/net-news/tin/tin-1.6.2.ebuild,v 1.3 2004/04/23 19:20:20 fmccor Exp $

IUSE="ncurses ipv6"

S=${WORKDIR}/${P}
DESCRIPTION="A threaded NNTP and spool based UseNet newsreader"
SRC_URI="ftp://ftp.tin.org/pub/news/clients/tin/v1.6/${P}.tar.gz"
HOMEPAGE="http://www.tin.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ia64 ~amd64 ~sparc"

DEPEND="ncurses? ( sys-libs/ncurses )"

src_compile() {
	local myconf
	[ -f /etc/NNTP_INEWS_DOMAIN ] \
		&& myconf="${myconf} --with-domain-name=/etc/NNTP_INEWS_DOMAIN"

	./configure \
		`use_enable ncurses curses` \
		`use_with ncurses` \
		`use_enable ipv6` \
		--verbose \
		--enable-nntp-only \
		--enable-prototypes \
		--disable-echo \
		--disable-mime-strict-charset \
		--with-coffee  \
		--enable-fascist-newsadmin \
		${myconf} || die
	make build || die
}

src_install() {
	dobin src/tin
	ln -s tin ${D}/usr/bin/rtin
	doman doc/tin.1
	dodoc doc/*
	insinto /etc/tin
	doins doc/tin.defaults
}
