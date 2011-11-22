# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libntlm/libntlm-1.3.ebuild,v 1.3 2011/11/22 16:17:19 phajdan.jr Exp $

EAPI=4

DESCRIPTION="Microsoft's NTLM authentication (libntlm) library"
HOMEPAGE="http://www.nongnu.org/libntlm/"
SRC_URI="http://www.nongnu.org/${PN}/releases/${P}.tar.gz"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc x86"
IUSE=""

src_configure() {
	econf --disable-valgrind-tests
}

src_install () {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README
}
