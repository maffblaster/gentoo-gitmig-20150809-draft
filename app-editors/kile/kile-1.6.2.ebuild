# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/kile/kile-1.6.2.ebuild,v 1.3 2004/06/24 21:57:42 agriffis Exp $

inherit kde
need-kde 3.1

DESCRIPTION="A Latex Editor and TeX shell for kde"
SRC_URI="mirror://sourceforge/kile/${P}.tar.gz"
HOMEPAGE="http://kile.sourceforge.net"

IUSE=""
SLOT=0

DEPEND="dev-lang/perl"
RDEPEND="$RDEPEND virtual/tetex"

# I cannot prove that amd64 or sparc work, but they were listed in 1.6.1 as well
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
LICENSE="GPL-2"

