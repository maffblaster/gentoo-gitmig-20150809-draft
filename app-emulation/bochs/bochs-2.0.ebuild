# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/bochs/bochs-2.0.ebuild,v 1.6 2004/05/04 15:40:33 kloeri Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Bochs is a pc emulator.
This ebuild is set up to emulate a Pentium, with a NE2000 network card, and a
CDROM drive. It also comes with a disk image using dlxlinux."
SRC_URI="mirror://sourceforge/bochs/${P}.tar.gz
	 http://bochs.sourceforge.net/guestos/dlxlinux3.tar.gz"
HOMEPAGE="http://bochs.sourceforge.net"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE="sdl"

DEPEND=">=sys-libs/glibc-2.1.3
	virtual/x11
	sdl? media-libs/libsdl"
KEYWORDS="x86 ~ppc ~alpha"

src_unpack() {
	unpack ${P}.tar.gz

	cd $S
	cp Makefile.in Makefile.in.orig
	sed -e "s:\$(WGET) \$(DLXLINUX_TAR_URL):cp ${DISTDIR}/dlxlinux3.tar.gz .:" \
	-e 's:BOCHSDIR=:BOCHSDIR=/usr/lib/bochs#:' \
	-e 's: $(BOCHSDIR): $(DESTDIR)$(BOCHSDIR):g' Makefile.in.orig > Makefile.in

}

src_compile() {

	[ "$ARCH" == "x86" ] && myconf="--enable-idle-hack"
	use sdl && myconf="${myconf} --with-sdl" \
		|| myconf="${myconf} --without-sdl"
	./configure --enable-fpu --enable-cdrom --enable-control-panel \
	--enable-ne2000 --enable-sb16=linux --enable-slowdown --prefix=/usr \
	--infodir=/usr/share/info --mandir=/usr/share/man --host=${CHOST} --with-x11 $myconf || die


	emake || die
}


src_install () {

	make DESTDIR=${D} install || die
	dodoc CHANGES COPYING CVS README TESTFORM.txt
}

