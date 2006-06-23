# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Module-Pluggable/Module-Pluggable-3.01.ebuild,v 1.1 2006/06/23 20:14:58 mcummings Exp $

inherit perl-module

DESCRIPTION="automatically give your module the ability to have plugins"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/S/SI/SIMONW/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/module-build"
