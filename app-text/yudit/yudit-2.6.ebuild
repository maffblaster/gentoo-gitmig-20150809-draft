# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/yudit/yudit-2.6.ebuild,v 1.7 2002/12/09 04:17:45 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Yudit is a free (Y)unicode text editor for all unices"
SRC_URI="http://yudit.org/download/${P}.tar.gz"
HOMEPAGE="http://www.yudit.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND="virtual/x11 
	>=sys-devel/gettext-0.10"

src_compile() {
	econf || die
	emake || make || die
}

src_install () {
	make DESTDIR=${D} install || die
}
