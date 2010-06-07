# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/safecat/safecat-1.12.ebuild,v 1.4 2010/06/07 12:49:26 flameeyes Exp $

inherit fixheadtails eutils toolchain-funcs flag-o-matic

IUSE=""

DESCRIPTION="Safecat implements qmail's maildir algorithm, copying standard input safely to a specified directory."
HOMEPAGE="http://jeenyus.net/~budney/linux/software/safecat.html"
SRC_URI="http://jeenyus.net/~budney/linux/software/${PN}/${P}.tar.gz"

DEPEND="sys-apps/groff"
RDEPEND=""
SLOT="0"
LICENSE="BSD"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}

	# applying maildir-patch
	epatch ${FILESDIR}/safecat-1.11-gentoo.patch

	ht_fix_file Makefile make-compile.sh

	sed -ni '/man\|doc/!p' hier.c
}

src_compile() {
	# safecat segfaults on gcc-4.0 x86 with -Os, seems to be okay with -O2
	if [[ $(gcc-major-version).$(gcc-minor-version) == 4.0 ]]; then
		replace-flags -Os -O2
	fi

	echo "/usr" > conf-root
	echo "$(tc-getCC) ${CFLAGS}" > conf-cc
	echo "$(tc-getCC) ${LDFLAGS}" > conf-ld

	# bug #295751
	emake -j1 it man || die
}

src_install() {
	dodir /usr
	echo "${D}/usr" > conf-root
	emake -j1 man setup check || die
	dodoc CHANGES COPYING INSTALL README
	doman maildir.1 safecat.1
}
