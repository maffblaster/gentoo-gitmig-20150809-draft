# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gdb/gdb-5.1.ebuild,v 1.5 2002/08/14 11:56:44 murphy Exp $

A=${P}.tar.bz2
S=${WORKDIR}/${P}
DESCRIPTION="GNU debugger"
HOMEPAGE="http://www.gnu.org/software/gdb/gdb.html"
SRC_URI="ftp://sourceware.cygnus.com/pub/gdb/releases/${A}
	 ftp://ftp.freesoftware.com/pub/sourceware/gdb/releases/${A}"
LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2-r2
	nls? ( sys-devel/gettext )"

RDEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2-r2"


src_compile() {

	local myconf
	if [ -z "`use nls`" ] ; then
		myconf="--disable-nls"
	fi
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--without-included-regex \
		--without-included-gettext \
		--host=${CHOST} \
		${myconf} || die

	emake
}

src_install() {

	emake prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die

	cd gdb/doc
	emake infodir=${D}/usr/share/info \
		install-info || die

	cd ${S}/bfd/doc
	emake infodir=${D}/usr/share/info \
		install-info || die

	cd ${S}

	# These includes and libs are in binutils already
	rm -f ${D}/usr/lib/libbfd.*
	rm -r ${D}/usr/lib/libiberty.*
	rm -f ${D}/usr/lib/libopcodes.*

	rm -rf ${D}/usr/include

	dodoc COPYING* README

	docinto gdb
	dodoc gdb/CONTRIBUTE gdb/COPYING* gdb/README \
		gdb/MAINTAINERS gdb/NEWS gdb/ChangeLog* \
		gdb/TODO

	docinto sim
	dodoc sim/ChangeLog sim/MAINTAINERS sim/README-HACKING

	docinto mmalloc
	dodoc mmalloc/COPYING.LIB mmalloc/MAINTAINERS \
		mmalloc/ChangeLog mmalloc/TODO
}




