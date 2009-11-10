# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gearman/Gearman-1.10.ebuild,v 1.1 2009/11/10 10:15:19 robbat2 Exp $

MODULE_AUTHOR="DORMANDO"
inherit perl-module

DESCRIPTION="Gearman distributed job system"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-perl/string-crc32
		dev-lang/perl"

mydoc="CHANGES HACKING TODO"
# testsuite requires gearman server
SRC_TEST="never"
