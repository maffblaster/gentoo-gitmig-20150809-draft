# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/cmospwd/cmospwd-4.7.ebuild,v 1.1 2005/11/07 20:02:45 dragonheart Exp $

inherit toolchain-funcs

DESCRIPTION="CmosPwd decrypts password stored in cmos used to access BIOS SETUP"
HOMEPAGE="http://www.cgsecurity.org/index.html?cmospwd.html"
SRC_URI="http://www.cgsecurity.org/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/libc"

src_compile() {
	cd src
	$(tc-getCC) ${CFLAGS} cmospwd.c -o cmospwd || die
}

src_install() {
	dosbin src/cmospwd || die
	dodoc cmospwd.txt || die
}

