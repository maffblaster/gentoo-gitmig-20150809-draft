# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdbakeoven/cdbakeoven-1.8.9.ebuild,v 1.3 2002/07/11 06:30:10 drobbins Exp $

inherit kde-base || die

need-kde 3

DESCRIPTION="CDBakeOven, KDE CD Writing Software"
SRC_URI="mirror://sourceforge/cdbakeoven/${P}.tar.bz2"
HOMEPAGE="http://cdbakeoven.sourceforge.net"
S=${WORKDIR}/${P}
LICENSE="GPL-2"

newdepend ">=media-libs/libogg-1.0_rc2
	>=media-sound/mpg123-0.59
	>=media-sound/cdparanoia-3.9.8
	>=app-cdr/cdrtools-1.11"

