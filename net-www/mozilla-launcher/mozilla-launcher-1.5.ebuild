# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla-launcher/mozilla-launcher-1.5.ebuild,v 1.1 2004/05/03 02:56:56 agriffis Exp $

IUSE=""

DESCRIPTION="Script that launches mozilla or firefox"
HOMEPAGE=""
SRC_URI="mirror://gentoo/${P}.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~mips"

DEPEND=""
RDEPEND=""

S=${WORKDIR}

src_install() {
	newbin ${P} mozilla-launcher
}
