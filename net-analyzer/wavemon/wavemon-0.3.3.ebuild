# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author / Maintainer Ben Lutgens <lamer@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/wavemon/wavemon-0.3.3.ebuild,v 1.1 2002/05/29 03:12:18 lamer Exp $

DESCRIPTION="ncurses based monitor util for your wavelan cards"
LICENSE="GPL-2"

DEPEND="sys-libs/ncurses
		virtual/glibc"
	
SRC_URI="http://www.jm-music.de/wavemon-current.tar.gz"

src_compile() {
	emake || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/{man1,man5}
	make prefix="${D}/usr" mandir="${D}/usr/share/man" install
	dodoc README TODO COPYING AUTHORS
}
