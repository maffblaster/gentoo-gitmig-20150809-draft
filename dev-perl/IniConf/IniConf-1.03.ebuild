# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IniConf/IniConf-1.03.ebuild,v 1.7 2006/08/05 04:55:47 mcummings Exp $

inherit perl-module

DESCRIPTION="A Module for reading .ini-style configuration files"
SRC_URI="mirror://cpan/authors/id/R/RB/RBOW/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/R/RB/RBOW/${P}.readme"
IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="ia64 sparc x86"

SRC_TEST="do"

DEPEND="dev-perl/Config-IniFiles
	dev-lang/perl"
RDEPEND="${DEPEND}"

