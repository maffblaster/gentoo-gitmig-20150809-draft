# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/e-fancylauncher/e-fancylauncher-0.7.ebuild,v 1.3 2003/11/06 19:49:23 mr_bones_ Exp $

S="${WORKDIR}/Epplets-${PV}"

DESCRIPTION="E-FancyLauncher epplet"
SRC_URI="http://www.docs.uu.se/~adavid/Epplets/E-FancyLauncher-${PV}.tgz"

HOMEPAGE="http://www.docs.uu.se/~adavid/Epplets"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"
S=${WORKDIR}/E-FancyLauncher

DEPEND="x11-plugins/epplets"

src_compile() {
	make clean
	emake
}

src_install () {
	dodir /usr/bin
	dodir /usr/share/enlightenment
	EBIN=${D}/usr/bin \
	EROOT=${D}/usr/share/enlightenment \
	einstall
	dodoc ChangeLog
}
