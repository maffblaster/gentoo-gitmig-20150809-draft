# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmerlin/kmerlin-1.0-r1.ebuild,v 1.8 2003/07/22 20:13:20 vapier Exp $

inherit kde-base

need-kde 3
# despite being a kde3 app, its configure script was generated by autoconf 2.13 so:
need-autoconf 2.1

DESCRIPTION="KDE MSN Messenger"
SRC_URI="mirror://sourceforge/kmerlin/${P}.tar.gz"
HOMEPAGE="http://kmerlin.olsd.de"


LICENSE="GPL-2"
KEYWORDS="x86"
