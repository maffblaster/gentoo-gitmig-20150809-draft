# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/glastree/glastree-0.58.ebuild,v 1.1 2002/12/08 21:44:47 sethbc Exp $

S=${WORKDIR}/${P}
DESCRIPTION="glastree is a poor mans snapshot utility using hardlinks written in perl"
HOMEPAGE="http://www.igmus.org/code/"
SRC_URI="http://www.igmus.org/files/${P}.tar.gz"
DEPEND="sys-devel/perl dev-perl/Date-Calc"
SLOT="0"
KEYWORDS="x86"
LICENSE="public-domain"

src_install() {
	dodir /usr/share/man/man1
	make INSTROOT=${D}/usr INSTMAN=share/man install || die
	dodoc README CHANGES THANKS TODO
}
