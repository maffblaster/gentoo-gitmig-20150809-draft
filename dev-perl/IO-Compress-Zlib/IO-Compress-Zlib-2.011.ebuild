# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Compress-Zlib/IO-Compress-Zlib-2.011.ebuild,v 1.1 2008/05/20 15:41:06 tove Exp $

MODULE_AUTHOR=PMQS

inherit perl-module

DESCRIPTION="Read/Write compressed files"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-perl/IO-Compress-Base-${PV}
	>=dev-perl/Compress-Raw-Zlib-${PV}
	dev-lang/perl"

SRC_TEST="do"
