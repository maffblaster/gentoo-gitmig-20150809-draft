# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Compress-Raw-Bzip2/Compress-Raw-Bzip2-2.020.ebuild,v 1.1 2009/06/03 22:26:04 tove Exp $

EAPI=2

MODULE_AUTHOR=PMQS
inherit perl-module

DESCRIPTION="Low-Level Interface to bzip2 compression library"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="test"

RDEPEND="app-arch/bzip2"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do

src_configure(){
	BUILD_BZIP2=0 BZIP2_INCLUDE= BZIP2_LIB= \
		perl-module_src_configure
}
