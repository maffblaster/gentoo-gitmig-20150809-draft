# Copyright 999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/xforms/xforms-1.0_rc4.ebuild,v 1.3 2002/08/01 11:12:30 danarmak Exp $

DESCRIPTION="This is a sample skeleton ebuild file"
HOMEPAGE="http://world.std.com/~xforms"
SRC_URI="ftp://ncmir.ucsd.edu/pub/xforms/OpenSource/xforms-1.0RC4.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
DEPEND="virtual/x11"
PROVIDES="virtual/xforms"
S="${WORKDIR}/xforms-1.0RC4"

src_unpack() {

    unpack $A
    cd $S
    
    # use custom CFLAGS
    cp Imakefile Imakefile.orig
    sed -e "s:CDEBUGFLAGS =:CDEBUGFLAGS = ${CFLAGS} #:" \
        -e "s:CDEBUGFLAGS	=:CDEBUGFLAGS	= ${CFLAGS} #:" Imakefile.orig > Imakefile

}

src_compile() {
	xmkmf -a
	cp Makefile Makefile.orig
	sed -e s/'demos$'// Makefile.orig > Makefile
	
	# use custom CFLAGS
	cp Makefile Makefile.orig
	sed -e "s:CDEBUGFLAGS =:CDEBUGFLAGS = ${CFLAGS} #:" \
		-e "s:CDEBUGFLAGS	=:CDEBUGFLAGS	= ${CFLAGS} #:" Makefile.orig > Makefile

	make || die
}

src_install () {
	make DESTDIR=${D} install || die
}
