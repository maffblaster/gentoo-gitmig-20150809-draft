# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iptables/iptables-1.2.7a-r2.ebuild,v 1.3 2003/01/08 09:27:20 aliz Exp $

inherit eutils

S=${WORKDIR}/${P}
DESCRIPTION="Kernel 2.4 firewall, NAT and packet mangling tools"
SRC_URI="http://www.iptables.org/files/${P}.tar.bz2"
HOMEPAGE="http://www.iptables.org/"
KEYWORDS="x86 alpha sparc"
SLOT="0"
# iptables is dependent on kernel sources.  Strange but true.
DEPEND="virtual/glibc
	sys-kernel/linux-headers"
LICENSE="GPL-2"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-files

	chmod +x extensions/.IMQ-test*

	sed -i -e "s/-O2/${CFLAGS}/g" -e "s:/usr/local::g" Makefile
}

src_compile() {
	# iptables and libraries are now installed to /sbin and /lib, so that
	# systems with remote network-mounted /usr filesystems can get their
	# network interfaces up and running correctly without /usr.

	make \
		LIBDIR=/lib \
		BINDIR=/sbin \
		MANDIR=/usr/share/man \
		INCDIR=/usr/include \
		KERNEL_DIR=/usr/src/linux \
		|| die
}

src_install() {
#	dodir /usr/{lib,share/man/man8,sbin}

	make DESTDIR=${D} MANDIR=/usr/share/man install

	dodoc COPYING KNOWN_BUGS
	dodir /var/lib/iptables ; keepdir /var/lib/iptables
	exeinto /etc/init.d
	newexe ${FILESDIR}/iptables.init iptables
	insinto /etc/conf.d
	newins ${FILESDIR}/iptables.confd iptables
}

pkg_postinst() {
	einfo "This package now includes an initscript which loads and saves"
	einfo "rules stored in /var/lib/iptables/rules-save"
	einfo "This location can be changed in /etc/conf.d/iptables"
}
