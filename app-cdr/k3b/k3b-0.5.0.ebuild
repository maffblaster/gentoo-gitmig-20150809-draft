# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-cdr/k3b/k3b-0.5.0.ebuild,v 1.1 2001/12/06 16:57:05 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kdelibs 2.2
need-qt 2.2

DESCRIPTION="K3b, KDE CD Writing Software"
SRC_URI="http://prdownloads.sourceforge.net/k3b/${P}.tar.gz"
HOMEPAGE="http://k3b.sourceforge.net"

S=${WORKDIR}/${P}

NEWDEPEND=">=kde-base/kdebase-2.2
	>=media-sound/mpg123-0.59
	>=media-sound/cdparanoia-3.9.8
	>=app-cdr/cdrtools-1.11
	>=app-cdr/cdrdao-1.1.5"

DEPEND="$DEPEND $NEWDEPEND"
RDEPEND="$RDEPEND $NEWDEPEND"

