# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bit-Vector/Bit-Vector-6.3-r1.ebuild,v 1.13 2006/08/04 22:37:22 mcummings Exp $

inherit perl-module

DESCRIPTION="Efficient bit vector, set of integers and big int math library"
SRC_URI="mirror://cpan/authors/id/S/ST/STBEY/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~stbey/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc alpha sparc s390"
IUSE=""
DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
