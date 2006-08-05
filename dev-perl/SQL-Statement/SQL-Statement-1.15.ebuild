# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Statement/SQL-Statement-1.15.ebuild,v 1.4 2006/08/05 20:23:20 mcummings Exp $

inherit perl-module

DESCRIPTION="Small SQL parser and engine"
SRC_URI="mirror://cpan/authors/id/J/JZ/JZUCKER/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/J/JZ/JZUCKER/${P}.readme"

IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="ia64 sparc ~x86"

SRC_TEST="do"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
