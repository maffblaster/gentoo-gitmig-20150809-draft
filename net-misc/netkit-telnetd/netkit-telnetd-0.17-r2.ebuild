# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Achim Gottinger <achim@gentoo.org>, Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-misc/netkit-telnetd/netkit-telnetd-0.17-r2.ebuild,v 1.3 2002/07/09 09:42:49 phoenix Exp $

P2=netkit-telnet-${PV}
S=${WORKDIR}/${P2}
DESCRIPTION="Standard Linux telnet client"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P2}.tar.gz"
KEYWORDS="x86"
LICENSE="bsd"
SLOT="0"

DEPEND="virtual/glibc >=sys-libs/ncurses-5.2"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/netkit-telnetd-0.17-gentoo.patch || die

}

src_compile() {                           
	./configure --prefix=/usr || die
	cp MCONFIG MCONFIG.orig
	sed -e "s/-pipe -O2/${CFLAGS}/" -e "s:-Wpointer-arith::" MCONFIG.orig > MCONFIG
	make || die
	cd telnetlogin
	make || die
}

src_install() {
	into /usr
	dobin telnet/telnet
	#that's it if we're going on a build image
	use build && return
	
	dosbin telnetd/telnetd
	dosym telnetd /usr/sbin/in.telnetd
	dosbin telnetlogin/telnetlogin
	doman telnet/telnet.1
	doman telnetd/*.8
	dosym telnetd.8.gz /usr/share/man/man8/in.telnetd.8.gz
	doman telnetlogin/telnetlogin.8
	dodoc BUGS ChangeLog README
	newdoc telnet/README README.telnet
	newdoc telnet/TODO TODO.telnet
}


