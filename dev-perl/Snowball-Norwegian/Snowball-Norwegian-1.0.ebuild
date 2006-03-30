# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Snowball-Norwegian/Snowball-Norwegian-1.0.ebuild,v 1.5 2006/03/30 23:17:41 agriffis Exp $

inherit perl-module

DESCRIPTION="Porters stemming algorithm for Norwegian"
HOMEPAGE="http://search.cpan.org/~asksh/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AS/ASKSH/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"
