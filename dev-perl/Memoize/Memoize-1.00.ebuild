# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Memoize/Memoize-1.00.ebuild,v 1.1 2002/06/28 12:41:13 seemant Exp $

inherit perl-module

MY_P=Memoize-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="Generic Perl function result caching system"
LICENSE="Artistic | GPL-2"
SRC_URI="http://www.cpan.org/modules/by-module/Memoize/${MY_P}.tar.gz"
HOMEPAGE="http://perl.plover.com/Memoize/"

SLOT="0"

src_compile() {
	base_src_compile
	base_src_test || die "test failed"
}
