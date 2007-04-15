# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Sys-Syslog/Sys-Syslog-0.18.ebuild,v 1.9 2007/04/15 21:18:55 corsair Exp $

inherit perl-module

DESCRIPTION="Provides same functionality as BSD syslog"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/S/SA/SAPER/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

# Tests disabled - they attempt to verify on the live system
#SRC_TEST="do"
