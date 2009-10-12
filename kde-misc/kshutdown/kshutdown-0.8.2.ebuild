# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kshutdown/kshutdown-0.8.2.ebuild,v 1.5 2009/10/12 08:36:05 abcd Exp $

inherit kde

DESCRIPTION="A shutdown manager for KDE"
HOMEPAGE="http://kshutdown.sourceforge.net"
SRC_URI="mirror://sourceforge/kshutdown/${P}.tar.bz2"
LICENSE="GPL-2"

IUSE=""
KEYWORDS="amd64 ~ppc x86"
SLOT="0"

RDEPEND="|| ( ( =kde-base/kdesu-3.5* =kde-base/kcontrol-3.5* =kde-base/kdialog-3.5* )
	=kde-base/kdebase-3.5* )"

need-kde 3.4
