# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lib-compat/lib-compat-1.1.ebuild,v 1.4 2003/02/14 16:01:10 agriffis Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Compatibility C++ and libc5 and libc6 libraries for programs new and old"
SRC_URI="x86? ( mirror://gentoo/${P}.tar.bz2 )"
HOMEPAGE="http://www.gentoo.org/"

SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
LICENSE="GPL"

DEPEND="virtual/glibc"

src_install() {
	use x86 && {
		into /usr
		dolib.so *.so*
		preplib /usr
	}
}
