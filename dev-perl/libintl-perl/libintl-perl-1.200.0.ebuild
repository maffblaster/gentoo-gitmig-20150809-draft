# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libintl-perl/libintl-perl-1.200.0.ebuild,v 1.5 2012/03/24 16:17:03 grobian Exp $

EAPI=4

MODULE_AUTHOR=GUIDO
MODULE_VERSION=1.20
inherit perl-module

DESCRIPTION="Perl internationalization library that aims to be compatible with the Uniforum message translations system"
HOMEPAGE="http://guido-flohr.net/projects/libintl-perl ${HOMEPAGE}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x64-freebsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""

SRC_TEST=do
