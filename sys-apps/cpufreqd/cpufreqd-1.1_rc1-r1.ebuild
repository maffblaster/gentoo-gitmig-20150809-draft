# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpufreqd/cpufreqd-1.1_rc1-r1.ebuild,v 1.2 2004/01/05 08:55:29 plasmaroo Exp $

S=${WORKDIR}/${P/_/-}

DESCRIPTION="Daemon to adjust CPU speed for power saving"
SRC_URI="mirror://sourceforge/${PN}/${P/_/-}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/cpufreqd/"
KEYWORDS="~x86 ~ppc -*"
LICENSE="GPL-2"
SLOT="0"

inherit eutils

src_unpack() {
	unpack ${A}
	cd ${S}
	#correct the init-script
	sed -i -e s:/bin/cpufreqd:/usr/bin/cpufreqd: ${S}/scripts/gentoo/cpufreqd
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README Authors TODO

	exeinto /etc/init.d
	newexe ${S}/scripts/gentoo/cpufreqd cpufreqd
}

pkg_postinst() {
	echo
	einfo "A default config file has been copied to /etc/cpufreqd.conf"
	echo
	einfo "CPUFreqd does not support using percentage frequencies on"
	einfo "2.6 kernels where sysfs is used instead - please manually"
	einfo "edit the config file to use an absolute value instead, if"
	einfo "you are using a 2.6 series kernel."
	echo
}
