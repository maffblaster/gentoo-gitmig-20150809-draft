# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/wavemon/wavemon-0.6.7.ebuild,v 1.1 2009/10/16 19:48:14 bangert Exp $

EAPI="2"

DESCRIPTION="Ncurses based monitor for IEEE 802.11 wireless LAN cards"
HOMEPAGE="http://eden-feed.erg.abdn.ac.uk/wavemon/"
SRC_URI="http://eden-feed.erg.abdn.ac.uk/wavemon/stable-releases/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~sparc ~x86"

IUSE=""
DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install \
		|| die "make install failed"

	dodoc AUTHORS ChangeLog README
}
