# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libstroke/libstroke-0.4.ebuild,v 1.8 2002/10/04 05:16:33 vapier Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A Stroke and Guesture recognition Library"
SRC_URI="http://www.etla.net/libstroke/${P}.tar.gz"
HOMEPAGE="http://www.etla.net/libstroke"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=sys-libs/glibc-2.1.3
	>=x11-base/xfree-4.0.3"

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc COPYING COPYRIGHT CREDITS ChangeLog README 
}
