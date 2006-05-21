# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/teg/teg-0.11.1.ebuild,v 1.10 2006/05/21 18:39:18 corsair Exp $

inherit gnome2

DESCRIPTION="Gnome Risk Clone"
HOMEPAGE="http://teg.sourceforge.net/"
SRC_URI="mirror://sourceforge/teg/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="nls"

DEPEND="dev-libs/glib
	gnome-base/libgnomeui
	gnome-base/libgnome"
RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"
