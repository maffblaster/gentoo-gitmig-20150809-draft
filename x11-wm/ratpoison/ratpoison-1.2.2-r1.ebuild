# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/ratpoison/ratpoison-1.2.2-r1.ebuild,v 1.1 2003/10/15 09:03:14 weeve Exp $

DESCRIPTION="Ratpoison is an extremely light-weight and barebones wm modelled after screen."
HOMEPAGE="http://ratpoison.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~ppc"

DEPEND="virtual/x11"

src_compile() {
	econf
	emake CFLAGS="${CFLAGS} -I/usr/X11R6/include" || die "Failed to compile"
}

src_install() {
	einstall

	echo "#!/bin/bash" > ratpoison
	echo "/usr/bin/ratpoison" >> ratpoison
	exeinto /etc/X11/Sessions
	doexe ratpoison

	# handle docs/misc
	dodoc INSTALL TODO README NEWS AUTHORS ChangeLog
	docinto example
	dodoc doc/ipaq.ratpoisonrc contrib/{genrpbindings,ratpoison.el,split.sh}
	rm -Rf ${D}/usr/share/{doc/ratpoison,ratpoison}

	insinto /etc
	doins ${FILESDIR}/ratpoisonrc
}
