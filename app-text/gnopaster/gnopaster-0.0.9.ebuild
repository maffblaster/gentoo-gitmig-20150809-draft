# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gnopaster/gnopaster-0.0.9.ebuild,v 1.3 2007/06/21 21:55:00 gustavoz Exp $

DESCRIPTION="A submitter for gnopaste, a nopaste service like http://nopaste.info"
HOMEPAGE="http://gnopaste.sf.net"
SRC_URI="mirror://sourceforge/gnopaste/${P}.pl.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl
	dev-perl/libwww-perl
	dev-perl/Config-Simple"

src_install() {
	dobin ${WORKDIR}/${P}.pl
	dosym ${P}.pl /usr/bin/${PN}
}
