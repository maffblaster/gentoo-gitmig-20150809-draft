# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/netscape-plugger/netscape-plugger-5.0.ebuild,v 1.4 2004/07/14 06:03:42 mr_bones_ Exp $

MY_P=${P/netscape-/}
DESCRIPTION="Plugger streaming media plugin"
HOMEPAGE="http://fredrik.hubbe.net/plugger.html"
SRC_URI="http://fredrik.hubbe.net/plugger/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND="net-www/mozilla"

S="${WORKDIR}/${MY_P}"

src_compile () {
	emake linux || die
}

src_install () {
	dodir /etc
	make root=${D} prefix="/usr" install || die
}
