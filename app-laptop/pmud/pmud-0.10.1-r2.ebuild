# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/pmud/pmud-0.10.1-r2.ebuild,v 1.4 2004/07/14 01:22:18 agriffis Exp $

IUSE="X"


DESCRIPTION="PowerMac power management utilities"
SRC_URI="http://linuxppc.jvc.nl/${P}.tar.gz"
HOMEPAGE="http://penguinppc.org/"
KEYWORDS="ppc -x86 -amd64 -alpha -hppa -mips -sparc"
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/os-headers
	X? ( virtual/x11 )"
RDEPEND="sys-apps/util-linux"

src_unpack() {
	cd ${WORKDIR}
	unpack ${P}.tar.gz
	mv pmud-0.10 ${P}
	cd ${S}
	patch -p1 < ${FILESDIR}/pmud-file-locations.patch
	use X || patch -p1 <${FILESDIR}/pmud-makefile-x-gentoo.diff
}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	doman pmud.8 snooze.8 fblevel.8
	exeinto /sbin
	doexe pmud wakebay snooze fblevel
	exeinto /etc/power
	doexe ${FILESDIR}/pwrctl{,-local}
	exeinto /etc/init.d
	newexe ${FILESDIR}/pmud.start pmud
	insinto /etc
	doins ${FILESDIR}/power.conf
	use X && ( \
	doman batmon.8 xmouse.8
	exeinto /usr/bin
	doexe Batmon
	exeinto /usr/X11R6/bin
	doexe xmouse )
}
