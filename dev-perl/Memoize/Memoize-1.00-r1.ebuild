# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Memoize/Memoize-1.00-r1.ebuild,v 1.6 2003/02/13 07:42:02 gerk Exp $

inherit perl-module

MY_P=Memoize-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Generic Perl function result caching system"
SRC_URI="http://www.cpan.org/modules/by-module/Memoize/${MY_P}.tar.gz"
HOMEPAGE="http://perl.plover.com/Memoize/"

SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="x86 sparc alpha ppc"

