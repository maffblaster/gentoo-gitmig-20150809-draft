# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Deep/Test-Deep-0.096.ebuild,v 1.6 2007/01/19 16:06:51 mcummings Exp $

inherit perl-module
IUSE=""

DESCRIPTION="Test::Deep - Extremely flexible deep comparison"
SRC_URI="mirror://cpan/authors/id/F/FD/FDALY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~fdaly/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha amd64 ~ia64 ppc sparc ~x86"

SRC_TEST="do"
DEPEND="dev-perl/Test-NoWarnings
	dev-perl/Test-Tester
	dev-lang/perl"
