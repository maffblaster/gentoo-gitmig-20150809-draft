# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/kdiff3/kdiff3-0.931.ebuild,v 1.1 2003/01/30 16:02:30 danarmak Exp $
inherit kde-base 

DESCRIPTION="KDE-based frontend to diff3"
SRC_URI="mirror://sourceforge/kdiff3/${P}.tar.gz"
HOMEPAGE="http://kdiff3.sourceforge.net/"

KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

need-kde 3

RDEPEND="$RDEPEND sys-apps/diffutils"
