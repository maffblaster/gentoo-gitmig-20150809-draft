# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/debootstrap/debootstrap-0.2.4.ebuild,v 1.1 2003/09/18 12:50:39 lanius Exp $

DESCRIPTION="Debian bootstrap scripts"
HOMEPAGE="http://packages.qa.debian.org/d/debootstrap.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
SRC_URI="http://http.us.debian.org/debian/pool/main/d/debootstrap/debootstrap_${PV}.tar.gz
	mirror://gentoo/devices.tar.gz"
DEPEND="sys-devel/binutils
	net-misc/wget"
IUSE=""

S=${WORKDIR}/${P}

src_unpack() {
	unpack debootstrap_$PV.tar.gz
	cp ${DISTDIR}/devices.tar.gz ${S}
}

src_compile() {
	sed -i -e "s/chown/#chown/" Makefile
	make pkgdetails debootstrap-arch
}

src_install() {
	make DESTDIR=${D} install
}
