# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Mechanize/WWW-Mechanize-1.700.0.ebuild,v 1.1 2011/08/30 17:03:14 tove Exp $

EAPI=4

MODULE_AUTHOR=JESSE
MODULE_VERSION=1.70
inherit perl-module

DESCRIPTION="Handy web browsing in a Perl object"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND="dev-perl/IO-Socket-SSL
	|| (
		( >dev-perl/libwww-perl-6 dev-perl/HTML-Form )
		<dev-perl/libwww-perl-6
	)
	>=dev-perl/URI-1.36
	>=dev-perl/HTML-Parser-3.34
	dev-perl/Test-LongString"
DEPEND="${RDEPEND}
	test? ( dev-perl/PadWalker
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
		dev-perl/Test-Exception
		dev-perl/Test-NoWarnings
		dev-perl/Test-Taint
		>=dev-perl/Test-Warn-0.11
		dev-perl/Test-Memory-Cycle
		dev-perl/HTTP-Server-Simple
	)"

# configure to run the local tests, but not the ones which access the Internet
myconf="--local --nolive"
