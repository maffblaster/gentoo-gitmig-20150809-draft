# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-admin/mon/mon-0.99.2-r1.ebuild,v 1.4 2002/08/13 21:48:57 pvdabeel Exp $

S=${WORKDIR}/${P}
DESCRIPTION="mon is a highly configurable service monitoring daemon."
SRC_URI="ftp://ftp.kernel.org/pub/software/admin/mon/${P}.tar.bz2"
HOMEPAGE="http://www.kernel.org/software/mon/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=dev-perl/Mon-0.9
	>=dev-perl/Time-HiRes-01.20
	>=dev-perl/Period-1.20-r2"

src_compile() {

	cd ${S}/mon.d
	make CC="gcc $CFLAGS" || die
}

src_install () {

	exeinto /usr/sbin
	doexe mon clients/mon*

	insinto /usr/lib/mon/utils
	doins utils/*

	exeinto /usr/lib/mon/alert.d ; doexe alert.d/*
	exeinto /usr/lib/mon/mon.d ; doexe mon.d/*.monitor
	insopts -g uucp -m 02555 ; doins mon.d/*.wrap
	
	dodir /var/log/mon.d
	dodir /var/lib/mon.d

	doman doc/*.1
	doman doc/*.8
	dodoc CHANGES COPYING CREDITS KNOWN-PROBLEMS
	dodoc mon.lsm README TODO VERSION
	docinto txt ; dodoc doc/README*
	docinto etc ; dodoc etc/*
	newdoc ${FILESDIR}/mon.cf mon.cf.sample

	exeinto /etc/init.d
	newexe ${FILESDIR}/mon.rc6 mon
	insinto /etc/mon
	newins ${FILESDIR}/mon.cf mon.cf.sample
}
