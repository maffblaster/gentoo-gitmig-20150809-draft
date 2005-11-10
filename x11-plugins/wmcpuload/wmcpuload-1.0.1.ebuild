# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcpuload/wmcpuload-1.0.1.ebuild,v 1.14 2005/11/10 08:52:59 s4t4n Exp $

IUSE=""
DESCRIPTION="WMCPULoad is a program to monitor CPU usage."
HOMEPAGE="http://www.sh.rim.or.jp/~ssato/dockapp/index.shtml"
SRC_URI="http://www.sh.rim.or.jp/~ssato/src/${P}.tar.bz2"

DEPEND="virtual/x11"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~mips ppc ppc64 sparc x86"

src_install () {
	einstall || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
