# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/reiserfsprogs/reiserfsprogs-3.6.5.ebuild,v 1.1 2003/03/21 17:01:02 lostlogic Exp $

inherit flag-o-matic eutils

filter-flags -fPIC

S=${WORKDIR}/${P}
DESCRIPTION="Reiserfs Utilities"
SRC_URI="ftp://ftp.namesys.com/pub/reiserfsprogs/${P}.tar.gz"
HOMEPAGE="http://www.namesys.com"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

DEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}

	# NOTE: this patch needs to be applied to any architecture that has
	# /usr/include/asm/bitops.h entirely wrapped with #ifdef __KERNEL__.
	# This is needed because asm-i386/bitops.h is broken and reiserfsprogs
	# relies on the fact that it is broken. the reiserfsprogs people have
	# been made aware of this fact. hopefully this patch won't be needed
	# in future versions.
	# I bet sparc needs this patch too, but I don't have a machine to test on.
	if [ "${ARCH}" = "ppc" ]; then
		cd ${S}
		epatch ${FILESDIR}/reiserfsprogs-3.6.4-bitops.patch
	fi
}

src_compile() {
	cd ${S}
	./configure --prefix=/ || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodir /usr/share
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README

	cd ${D}
	mv man usr/share
	dosym /sbin/reiserfsck /sbin/fsck.reiserfs
}

