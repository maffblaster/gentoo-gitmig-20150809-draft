# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-libs/openslp/openslp-1.0.8a.ebuild,v 1.3 2002/07/11 06:30:47 drobbins Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An open-source implementation of Service Location Protocol"
SRC_URI="mirror://sourceforge/openslp/${P}.tar.gz"
HOMEPAGE="http://www.openslp.org"

DEPEND="virtual/glibc"

src_compile() {
	
	econf || die
    make || die

}

src_install () {

    einstall || die
    dodoc AUTHORS COPYING ChangeLog NEWS README* THANKS 
    rm -rf ${D}/usr/doc
    dohtml -r .

}
