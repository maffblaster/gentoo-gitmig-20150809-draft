# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/nettrom/nettrom-2.3.3.ebuild,v 1.1 2003/02/24 02:38:48 zwelch Exp $

DESCRIPTION="NetWinder ARM bootloader and utilities"
HOMEPAGE="http://www.netwinder.org/"
SRC_URI="http://gentoo.superlucidity.net/arm/netwinder/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"

# no one but arm wants this package - binaries included
KEYWORDS="arm -x86 -alpha -ppc -mips -hppa -sparc"

IUSE=""
DEPEND="virtual/glibc"
#RDEPEND=""

S=${WORKDIR}/${P}

src_unpack() {
	/bin/true
}

src_install() {
	cd ${D}
	unpack ${P}.tar.gz
}

