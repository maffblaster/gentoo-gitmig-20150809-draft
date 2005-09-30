# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PlRPC/PlRPC-0.2018.ebuild,v 1.3 2005/09/30 21:50:54 matsuu Exp $

inherit perl-module

DESCRIPTION="The Perl RPC Module"
SRC_URI="mirror://cpan/authors/id/J/JW/JWIED/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/RPC/${P}.readme"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64 ~s390 ~sh ~ppc64"
IUSE=""

DEPEND=">=perl-core/Storable-1.0.7
	>=dev-perl/Net-Daemon-0.34"
