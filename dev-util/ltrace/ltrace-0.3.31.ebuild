# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ltrace/ltrace-0.3.31.ebuild,v 1.7 2004/02/22 22:34:25 agriffis Exp $

S=${WORKDIR}/${P}
DESCRIPTION="ltrace shows runtime library call information for dynamically linked executables"
HOMEPAGE="http://packages.debian.org/unstable/utils/ltrace.html"
SRC_URI="mirror://debian/pool/main/l/ltrace/${PN}_${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64"

DEPEND=">=sys-apps/sed-4
	virtual/glibc"

src_compile() {

	econf || die

	# modify CFLAGS (hopefully in a more time friendly way)
	sed -i "s/ -O2 / ${CFLAGS} /" Makefile

	emake all || make all || die
}

src_install() {
	einstall || die

	# documentation
	rm -rvf ${D}usr/doc/
	dodoc BUGS COPYING debian/changelog README TODO
}
