# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-OptList/Data-OptList-0.107.0.ebuild,v 1.5 2011/09/03 16:20:32 armin76 Exp $

EAPI=4

MODULE_AUTHOR=RJBS
MODULE_VERSION=0.107
inherit perl-module

DESCRIPTION="parse and validate simple name/value option pairs"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND="dev-perl/Sub-Install
	dev-perl/Params-Util"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
