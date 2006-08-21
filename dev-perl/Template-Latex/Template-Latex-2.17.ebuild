# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Template-Latex/Template-Latex-2.17.ebuild,v 1.3 2006/08/21 19:22:29 corsair Exp $

inherit perl-module eutils

DESCRIPTION="Template::Latex - Latex support for the Template Toolkit"
SRC_URI="mirror://cpan/authors/id/A/AN/ANDREWF/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~andrewf/${P}/"
IUSE="test"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc64 ~x86"
SRC_TEST="do"

DEPEND=">=dev-perl/Template-Toolkit-2.15
	virtual/perl-File-Spec
	virtual/tetex
	test? ( virtual/perl-Test-Harness )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/Makefile.patch
}
