# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-DBus/Net-DBus-0.33.4.ebuild,v 1.3 2007/01/07 23:57:56 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl extension for the DBus message system"
HOMEPAGE="http://search.cpan.org/~danberr/"
SRC_URI="mirror://cpan/authors/id/D/DA/DANBERR/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl
	sys-apps/dbus
	dev-perl/XML-Twig
	dev-util/pkgconfig"
