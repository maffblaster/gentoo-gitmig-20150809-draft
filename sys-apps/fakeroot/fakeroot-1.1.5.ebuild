# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/fakeroot/fakeroot-1.1.5.ebuild,v 1.3 2005/03/22 00:06:08 ferringb Exp $

DESCRIPTION="Run commands in an environment faking root privileges"
HOMEPAGE="http://joostje.op.het.net/fakeroot/index.html"
SRC_URI="mirror://debian/pool/main/f/fakeroot/${PF/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""

RDEPEND="virtual/libc"

src_install() {
	make DESTDIR=${D} install || die "install problem"
}
