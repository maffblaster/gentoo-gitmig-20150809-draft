# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.3.0.ebuild,v 1.11 2004/10/04 14:58:20 gmsoft Exp $

inherit kde-dist eutils

DESCRIPTION="KDE artwork package"

KEYWORDS="x86 amd64 sparc ppc ppc64 hppa"
IUSE="opengl xscreensaver"

DEPEND="opengl? ( virtual/opengl )
	~kde-base/kdebase-${PV}
	!ppc64? ( xscreensaver? ( x11-misc/xscreensaver ) )"

src_unpack() {
	kde_src_unpack
	sed -ie "s:X11R6/lib\(/X11\)\?:lib:g" kscreensaver/kxsconfig/Makefile.in
	if ! use arts; then
		epatch ${FILESDIR}/3.3.0-kfiresaver-configure.in.in.patch
		epatch ${FILESDIR}/3.3.0-kfiresaver-Makefile.am.patch
		cd ${S}
		make -f admin/Makefile.common
	fi
}

src_compile() {
	myconf="$myconf --with-dpms $(use_with opengl gl)"
	kde_src_compile
}
