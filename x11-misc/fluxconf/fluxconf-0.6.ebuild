# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fluxconf/fluxconf-0.6.ebuild,v 1.8 2002/12/09 04:41:51 manson Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Configuration editor for fluxbox"
SRC_URI="http://devaux.fabien.free.fr/flux/${P}.tar.bz2"
HOMEPAGE="http://devaux.fabien.free.fr/flux/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc "

DEPEND="=x11-libs/gtk+-1.2*"



src_compile() {

	emake || die
}

src_install () {

	dobin fluxconf fluxkeys || die

}
