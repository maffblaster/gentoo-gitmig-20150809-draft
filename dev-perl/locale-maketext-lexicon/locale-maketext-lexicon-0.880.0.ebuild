# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/locale-maketext-lexicon/locale-maketext-lexicon-0.880.0.ebuild,v 1.1 2011/08/01 18:58:23 tove Exp $

EAPI=4

MY_PN=Locale-Maketext-Lexicon
MODULE_AUTHOR=DRTECH
MODULE_VERSION=0.88
inherit perl-module

DESCRIPTION="Use other catalog formats in Maketext"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND=">=virtual/perl-locale-maketext-1.17"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
