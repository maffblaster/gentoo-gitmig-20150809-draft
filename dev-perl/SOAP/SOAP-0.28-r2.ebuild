# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SOAP/SOAP-0.28-r2.ebuild,v 1.5 2003/06/01 01:32:32 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Perl Module for SOAP"
SRC_URI="http://cpan.valueclick.com/modules/by-module/SOAP/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/SOAP/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="${DEPEND}
	dev-perl/libwww-perl
	>=dev-perl/XML-Parser-2.29
	>=dev-perl/mod_perl-1.24"
