# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Socket6/Socket6-0.23.ebuild,v 1.3 2011/04/20 12:56:14 jlec Exp $

MODULE_AUTHOR=UMEMOTO
inherit perl-module toolchain-funcs

DESCRIPTION="IPv6 related part of the C socket.h defines and structure manipulators"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"

src_unpack() {
	base_src_unpack
	tc-export CC
}
