# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/mutella/mutella-0.4.1.ebuild,v 1.3 2002/12/05 15:44:20 vapier Exp $

DESCRIPTION="Text-mode gnutella client"
SRC_URI="mirror://sourceforge/mutella/${P}.tar.gz"
HOMEPAGE="http://mutella.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

DEPEND="virtual/glibc
	sys-libs/readline"

src_compile() {
	CXXFLAGS="${CXXFLAGS} -DNAVE_NO_SLIST "
	econf
	emake || die "compile problem"
}

src_install() {
	make DESTDIR=${D} install || die "compile problem"
	dodoc AUTHORS ChangeLog COPYING INSTALL LICENSE KNOWN-BUGS README TODO
}
