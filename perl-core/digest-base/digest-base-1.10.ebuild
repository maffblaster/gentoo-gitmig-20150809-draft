# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/digest-base/digest-base-1.10.ebuild,v 1.10 2006/02/13 15:07:48 mcummings Exp $

inherit perl-module

MY_P=Digest-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Modules that calculate message digests"
HOMEPAGE="http://search.cpan.org/~gaas/${MY_P}/"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${MY_P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
SRC_TEST="do"
IUSE=""

mydoc="rfc*.txt"

DEPEND="virtual/perl-MIME-Base64"
