# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/splint/splint-3.1.2-r2.ebuild,v 1.1 2015/06/11 04:21:44 jer Exp $

EAPI=5
inherit autotools eutils

DESCRIPTION="Check C programs for vulnerabilities and programming mistakes"
HOMEPAGE="http://lclint.cs.virginia.edu/"
SRC_URI="http://www.splint.org/downloads/${P}.src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND="
	sys-devel/flex
"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-3.1.2-musl.patch

	# verbose compiler calls
	sed -i -e '/Compiling/d' src/Makefile.am || die
	# automake complains about trailing \
	sed -i -e '1600d' test/Makefile.am || die
	# do not install these header files twice
	sed -i -e '/\$(UnixHeaders)/s|stdio.h stdlib.h||g' lib/Makefile.am || die

	eautoreconf
}

src_configure() {
	# We do not need bison/yacc at all here
	# We definitely need libfl
	BISON=no LEXLIB=-lfl econf
}

src_compile() {
	local subdir
	# skip test/ subdir
	for subdir in src lib imports doc; do
		emake -j1 -C ${subdir}
	done
}

src_test() {
	emake -C test
}
