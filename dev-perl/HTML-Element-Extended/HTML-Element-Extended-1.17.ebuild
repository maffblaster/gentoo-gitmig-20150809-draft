# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Element-Extended/HTML-Element-Extended-1.17.ebuild,v 1.14 2012/03/25 15:21:02 armin76 Exp $

EAPI=2

MODULE_AUTHOR=MSISK
inherit perl-module

DESCRIPTION="Extension for manipulating a table composed of HTML::Element style components."

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ppc ppc64 x86"
IUSE=""

RDEPEND=">=dev-perl/HTML-Tree-3.01"
DEPEND="${RDEPEND}"

SRC_TEST="do"
