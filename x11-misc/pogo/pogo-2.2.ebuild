# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/pogo/pogo-2.2.ebuild,v 1.2 2004/02/28 19:19:17 aliz Exp $

S="${WORKDIR}/Epplets-${PV}"

DESCRIPTION="Pogo is a neat launcher program for X"
SRC_URI="http://www.ibiblio.org/propaganda/${PN}/${P}.tar.gz"

HOMEPAGE="http://www.ibiblio.org/propaganda/pogo/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
S=${WORKDIR}/${P}

DEPEND="virtual/x11
	media-libs/imlib
	media-libs/jpeg"

src_compile() {
	cp ${FILESDIR}/Makefile .
	make clean || die "Clean failed"
	for file in `grep -r /usr/local/ *|cut -f1 -d":"|sort|uniq`;do
		sed -i -e "s:/usr/local:/usr/share:g" ${file}
	done
	make all || "Make failed"
}

src_install () {
	dodoc README
	make DESTDIR="${D}" install || die "Install failed"
}
