# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/cooledit/cooledit-3.17.7.ebuild,v 1.2 2004/02/04 17:30:34 agriffis Exp $

IUSE="nls spell"

DESCRIPTION="Cooledit is a full featured multiple window text editor"
HOMEPAGE="http://${PN}.sourceforge.net/"
SRC_URI="http://${PN}.sourceforge.net/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
DEPEND="x11-base/xfree
	spell? ( app-text/ispell )"

src_compile() {
	# Fix for bug 40152 (04 Feb 2004 agriffis)
	addwrite /dev/ptym/clone:/dev/ptmx

	econf `use_enable nls` || die
	emake || die
}

src_install() {
	einstall
}
