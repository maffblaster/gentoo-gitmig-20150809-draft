# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXSLT/XML-LibXSLT-1.770.0.ebuild,v 1.1 2012/02/26 08:50:42 tove Exp $

EAPI=4

MODULE_AUTHOR=SHLOMIF
MODULE_VERSION=1.77
inherit perl-module

DESCRIPTION="A Perl module to parse XSL Transformational sheets using gnome's libXSLT"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

RDEPEND=">=dev-libs/libxslt-1.1.8
	>=dev-perl/XML-LibXML-1.70"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

SRC_TEST="do"
