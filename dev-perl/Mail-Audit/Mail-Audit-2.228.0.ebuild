# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Audit/Mail-Audit-2.228.0.ebuild,v 1.1 2015/07/01 13:24:45 zlogene Exp $

EAPI=5

MODULE_AUTHOR=RJBS
MODULE_VERSION=2.228
inherit perl-module

DESCRIPTION="Mail sorting/delivery module for Perl"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="dev-perl/MIME-tools
	>=dev-perl/MailTools-1.15
	virtual/perl-libnet
	dev-perl/File-Tempdir
	>=dev-perl/File-HomeDir-0.61"
DEPEND="${RDEPEND}"

SRC_TEST=do
