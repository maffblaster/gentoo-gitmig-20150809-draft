# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Craig Joly <joly@ee.ualberta.ca>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/feh/feh-1.0.1.ebuild,v 1.1 2001/08/25 23:04:31 csjoly Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A fast, lightweight imageviewer using imlib2"
SRC_URI="http://www.linuxbrit.co.uk/downloads/feh-1.0.1.tar.gz"
HOMEPAGE="http://www.linuxbrit.co.uk/feh"

DEPEND="media-libs/imlib2"

src_compile() {

	try ./configure  --host=${CHOST}
    try emake

}

src_install () {

    try make DESTDIR=${D} install
	dodoc AUTHORS COPYING ChangeLog README TODO
}

 
