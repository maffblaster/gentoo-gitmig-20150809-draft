# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmsysmon/wmsysmon-0.7.6-r1.ebuild,v 1.1 2002/06/24 16:52:42 gerk Exp $

S=${WORKDIR}/${P}

DESCRIPTION="WMaker DockUp to monitor: Memory usage, Swap usage, I/O 
throughput, system uptime, hardware interrupts, paging and swap activity."
SRC_URI="http://www.gnugeneration.com/software/wmsysmon/src/${P}.tar.gz"
HOMEPAGE="http://www.gnugeneration.com/software/wmsysmon/"
DEPEND="virtual/glibc x11-base/xfree"
RDEPEND=""
SLOT="0"
LICENSE="GPL"

src_compile() {
	mv src/Makefile src/Makefile.orig                                                       
	sed 's/^CFLAGS/#CFLAGS/' src/Makefile.orig > src/Makefile             
	rm src/Makefile.orig    
	make -C src
}

src_install () {
	dobin src/wmsysmon
	dodoc COPYING  ChangeLog  FAQ  README
}


