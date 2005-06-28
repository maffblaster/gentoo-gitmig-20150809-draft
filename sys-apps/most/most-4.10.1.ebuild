# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/most/most-4.10.1.ebuild,v 1.1 2005/06/28 16:36:08 ka0ttic Exp $

DESCRIPTION="An extremely excellent text file reader"
HOMEPAGE="http://freshmeat.net/projects/most/"
SLOT="0"
LICENSE="GPL-2"
SRC_URI="ftp://space.mit.edu/pub/davis/${PN}/${P}.tar.gz"
IUSE=""

# Note to arch maintainers: you'll need to add to src_install() for your
# arch, since the app's Makefile does strange things with different
# directories for each arch. -- ciaranm, 27 June 2004
KEYWORDS="~amd64 ~mips ~ppc ~ppc-macos ~sparc ~x86"

DEPEND=">=sys-libs/slang-1.4.2
	>=sys-libs/ncurses-5.2-r2"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc || die

	#*possible* (not definite) pmake problems, let's not risk it.
	make SYS_INITFILE="/etc/most.conf" || die
}

src_install() {
	# Changing this to use src/${ARCH}objs/most probably isn't a good
	# idea...
	local objsdir
	case ${ARCH} in
		x86)
			objsdir=x86objs
		;;
		amd64)
			objsdir=amd64objs
		;;
		sparc)
			objsdir=sparcobjs
		;;
		mips)
			objsdir=mipsobjs
		;;
		ppc)
			# This should also be the case of ppc-macos
			objsdir=ppcobjs
		;;
	esac
	dobin src/${objsdir:-objs}/most || die "Couldn't install binary"

	doman most.1

	dodoc COPYING COPYRIGHT README changes.txt
	docinto txt
	dodoc default.rc lesskeys.rc most-fun.txt
}
