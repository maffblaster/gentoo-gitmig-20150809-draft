# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/pv/pv-0.8.1.ebuild,v 1.13 2006/05/28 13:17:12 pylon Exp $

DESCRIPTION="Pipe Viewer: a tool for monitoring the progress of data through a pipe"
HOMEPAGE="http://www.ivarch.com/programs/pv.shtml"
SRC_URI="mirror://sourceforge/pipeviewer/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 ~sparc x86"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	make DESTDIR=${D} UNINSTALL=/bin/true install || die "install failed"
}
