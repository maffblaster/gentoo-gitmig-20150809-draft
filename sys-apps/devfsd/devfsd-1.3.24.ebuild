# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/devfsd/devfsd-1.3.24.ebuild,v 1.6 2002/10/19 03:42:44 vapier Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="Daemon for the Linux Device Filesystem"
SRC_URI="ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/devfsd/devfsd-v${PV}.tar.gz"
HOMEPAGE="http://www.atnf.csiro.au/~rgooch/linux/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"
RDEPEND="${DEPEND}"

src_unpack() {
  	unpack ${A}
	
	cd ${S}
	cp GNUmakefile GNUmakefile.orig
	sed -e "s:-O2:${CFLAGS}:g" \
		-e 's:/usr/man:/usr/share/man:' \
		-e '29,31d;11,16d' -e '6c\' \
		-e 'DEFINES	:= -DLIBNSL="\\"/lib/libnsl.so.1\\""' \
		GNUmakefile.orig > GNUmakefile
}

src_compile() {
	make || die
}

src_install() {
	dodir /sbin /usr/share/man /etc
	make PREFIX=${D} install || die

	#config file is handled in baselayout
	rm -f ${D}/etc/devfsd.conf
		
	dodoc devfsd.conf COPYING* INSTALL
}
