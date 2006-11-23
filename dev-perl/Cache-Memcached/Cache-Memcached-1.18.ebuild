# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cache-Memcached/Cache-Memcached-1.18.ebuild,v 1.10 2006/11/23 19:49:38 dertobi123 Exp $

inherit perl-module

DESCRIPTION="Perl API for memcached"
HOMEPAGE="http://www.danga.com/memcached/"
SRC_URI="mirror://cpan/authors/id/B/BR/BRADFITZ/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ~ppc64 sh sparc ~sparc-fbsd ~x86"
IUSE=""

DEPEND="!ia64? ( dev-perl/string-crc32 )
	dev-lang/perl"
RDEPEND="${DEPEND}"
