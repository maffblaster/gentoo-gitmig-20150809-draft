# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kreatecd/kreatecd-1.1.0.ebuild,v 1.9 2002/07/01 20:39:44 danarmak Exp $

inherit kde-base || die

need-kde 2.2

DESCRIPTION="KreateCD 1.1.0"
SRC_URI="mirror://sourceforge/kreatecd/${P}.tar.bz2"
HOMEPAGE="http://www.kreatecd.de"
LICENSE="GPL-2"
DEPEND="$DEPEND
	>=media-sound/mpg123-0.59
	>=media-sound/cdparanoia-3.9.8"
newdepend ">=app-cdr/cdrtools-1.11"
