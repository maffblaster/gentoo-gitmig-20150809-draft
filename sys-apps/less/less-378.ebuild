# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/less/less-378.ebuild,v 1.2 2002/10/19 03:42:44 vapier Exp $

DESCRIPTION="Excellent text file viewer"
HOMEPAGE="http://www.greenwoodsoftware.com/"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64 ~alpha"
SLOT="0"
LICENSE="GPL-2"
S=${WORKDIR}/${P}
SRC_URI="http://www.greenwoodsoftware.com/less/${P}.tar.gz"

DEPEND="virtual/glibc >=sys-libs/ncurses-5.2"
RDEPEND="${DEPEND}"

src_compile() {
	./configure --host=${CHOST} --prefix=/usr \
		    --sysconfdir=/etc || die
	emake || die
}

src_install() {
	dobin less lessecho lesskey
	exeinto /usr/bin ; newexe ${FILESDIR}/lesspipe.sh-r1 lesspipe.sh
	dodoc COPYING NEWS README LICENSE
	newman lesskey.nro lesskey.1
	newman less.nro less.1
}
