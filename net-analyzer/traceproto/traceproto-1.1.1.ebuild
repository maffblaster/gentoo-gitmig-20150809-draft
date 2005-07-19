# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/traceproto/traceproto-1.1.1.ebuild,v 1.2 2005/07/19 16:38:48 dholm Exp $

inherit eutils

DESCRIPTION="A traceroute-like utility that sends packets based on protocol"
HOMEPAGE="http://traceproto.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="debug ncurses"

RDEPEND=">=net-libs/libnet-1.1.0
	virtual/libpcap
	ncurses? ( sys-libs/ncurses )
	debug? ( dev-libs/dmalloc )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-fix-warnings.diff
}

src_compile() {
	local myconf
	use debug && myconf="--enable-dmalloc"
	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO INSTALL
}
