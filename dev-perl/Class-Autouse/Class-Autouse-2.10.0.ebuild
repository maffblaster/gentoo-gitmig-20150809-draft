# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Autouse/Class-Autouse-2.10.0.ebuild,v 1.3 2012/07/31 20:48:11 johu Exp $

EAPI=4

MODULE_AUTHOR=ADAMK
MODULE_VERSION=2.01
inherit perl-module

DESCRIPTION="Runtime aspect loading of one or more classes"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND=">=virtual/perl-Scalar-List-Utils-1.18"
DEPEND="${RDEPEND}"

SRC_TEST="do"
