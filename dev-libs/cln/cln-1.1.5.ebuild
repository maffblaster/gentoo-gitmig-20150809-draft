# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cln/cln-1.1.5.ebuild,v 1.8 2004/03/17 21:36:25 aliz Exp $

inherit flag-o-matic gcc

DESCRIPTION="CLN, a class library (C++) for numbers"

HOMEPAGE="http://www.ginac.de/CLN/"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="x86 ~ppc ~sparc"

SRC_URI="ftp://ftp.santafe.edu/pub/gnu/${P}.tar.gz"
#SRC_URI="ftp://ftpthep.physik.uni-mainz.de/pub/gnu/${P}.tar.gz"
DEPEND="dev-libs/gmp"

src_compile() {
	libtoolize -c -f

	# at least with gcc 2.95 and 3.1, cln won't like -O3 flag...
	replace-flags -O[3..9] -O2

	# and with gcc 2.95.3, it doesn't like funroll-loops as well...
	if [ "$( gcc-fullversion )" == "2.95.3" ]; then
		filter-flags -funroll-loops
		filter-flags -frerun-loop-opt
	fi

	./configure \
		--build=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--datadir=/usr/share/doc/${P} \
		--mandir=/usr/share/man || die "./configure failed"

	#it doesn't also like parallel make :)
	make || die
}

src_install () {
	make DESTDIR=${D} install || die
}
