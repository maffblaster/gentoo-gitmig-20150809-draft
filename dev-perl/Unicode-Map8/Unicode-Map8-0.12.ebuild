# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-Map8/Unicode-Map8-0.12.ebuild,v 1.17 2006/11/12 03:49:06 vapier Exp $

inherit perl-module

DESCRIPTION="Convert between most 8bit encodings"
HOMEPAGE="http://search.cpan.org/~gaas/${P}/"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=">=dev-perl/Unicode-String-2.06
	dev-lang/perl"
RDEPEND="${DEPEND}"

mydoc="TODO"
