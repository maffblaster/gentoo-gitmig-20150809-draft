# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/iproute/iproute-20010824.ebuild,v 1.3 2002/05/26 09:33:52 prez Exp $

S=${WORKDIR}/iproute2
DESCRIPTION="Kernel 2.4 routing and traffic control utilities"
SRC_URI="ftp://ftp.inr.ac.ru/ip-routing/iproute2-2.4.7-now-ss010824.tar.gz"
DEPEND="virtual/glibc virtual/linux-sources"

src_unpack() {
	unpack ${A}
	cd ${S}
	#Sync up with Debian's 20010824-8
	patch -p1 < ${FILESDIR}/iproute_20010824-8.diff || die
	
	# why was this commented out? were the programs segfaulting/not working?
	# they seem ok here when i compile with optimisations, so im reenabling
	# this patch. if theres problems, will glady change back. ~woodchip
	cp Makefile Makefile.orig
	sed -e "s/-O2/${CFLAGS}/g" \
	    -e "s/-Werror//g" Makefile.orig > Makefile

	# this next thing is required to enable diffserv (ATM support doesn't compile right now)
	cp Config Config.orig
	sed -e 's/DIFFSERV=n/DIFFSERV=y/g' -e 's/ATM=y/ATM=n/g' Config.orig > Config
}

src_compile() {
	emake || die
}

src_install() {
	cd ${S}/ip ; dosbin ifcfg ip routef routel rtacct rtmon rtpr
	cd ${S}/tc ; dosbin tc
	cd ${S} ; dodoc README* RELNOTES
	docinto examples/diffserv ; dodoc examples/diffserv/*
	docinto examples ; dodoc examples/*
	dodir /etc/iproute2
	insinto /etc/iproute2 ; doins ${S}/etc/iproute2/*
	if [ "`use tex`" ] ; then
		docinto ps ; dodoc doc/*.ps
	fi
}
