# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lincvs/lincvs-1.1.5.ebuild,v 1.2 2003/07/01 22:07:20 mholzer Exp $

IUSE="kde eutils"

S=${WORKDIR}/${P}
DESCRIPTION="A Graphical CVS Client"
SRC_URI="http://ppprs1.phy.tu-dresden.de/~trogisch/${PN}/download/LinCVS/${P}/${P}-0-generic-src.tgz"
HOMEPAGE="http://www.lincvs.org"

SLOT="0"
KEYWORDS="x86 ~sparc"
LICENSE="GPL-2"

DEPEND="kde? ( >=kde-base/kdelibs-2 )
	>=x11-libs/qt-3.0.5
	>=cvs-1.9"

RDEPEND="${DEPEND}
	dev-util/cvs"

src_compile() {
	# Patch wrapper script
	epatch ${FILESDIR}/${P}-gentoo.diff

	qmake -o Makefile lincvs.pro
	sed -e "s/^\tstrip/#\tstrip/" -i Makefile
	emake || die "make failed"
	emake install || die "make install failed"
}

src_install () {
	mkdir -p ${D}/usr/share
	cp -pR ${S}/LinCVS ${D}/usr/share
	dobin ${S}/LinCVS/lincvs
}
