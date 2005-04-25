# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GDGraph/GDGraph-1.43.ebuild,v 1.9 2005/04/25 16:41:15 mcummings Exp $

inherit perl-module
CATEGORY="dev-perl"

DESCRIPTION="perl5 module to create charts using the GD module"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${P}.readme"
SRC_URI="mirror://cpan/authors/id/M/MV/MVERB/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha amd64 ia64 ~ppc64"
IUSE=""

DEPEND="dev-perl/GDTextUtil
	media-libs/gd"

src_unpack() {
	unpack ${A}
	cd ${S}
	perl-module_src_prep
}
