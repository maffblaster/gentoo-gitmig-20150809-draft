# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-Syslog/Parse-Syslog-1.100.0.ebuild,v 1.1 2011/08/29 10:55:04 tove Exp $

EAPI=4

MODULE_AUTHOR=DSCHWEI
MODULE_VERSION=1.10
inherit perl-module

DESCRIPTION="Parse::Syslog - Parse Unix syslog files"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="virtual/perl-Time-Local
	dev-perl/File-Tail"
DEPEND="${RDEPEND}"

SRC_TEST="do"
