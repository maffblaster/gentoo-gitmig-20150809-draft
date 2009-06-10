# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp3splt/mp3splt-2.2.5.ebuild,v 1.1 2009/06/10 16:35:32 ssuominen Exp $

EAPI=2
inherit multilib

DESCRIPTION="a command line utility to split mp3 and ogg files without decoding."
HOMEPAGE="http://mp3splt.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/libmp3splt-0.5.6"
DEPEND="${RDEPEND}"

src_configure() {
	econf \
		--disable-dependency-tracking \
		--with-mp3splt-libraries=/usr/$(get_libdir) \
		--with-mp3splt-includes=/usr/include/lib${PN}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}
