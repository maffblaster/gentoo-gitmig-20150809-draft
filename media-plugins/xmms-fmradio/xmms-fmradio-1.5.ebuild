# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-fmradio/xmms-fmradio-1.5.ebuild,v 1.5 2004/06/18 06:04:50 eradicator Exp $

IUSE=""

MY_P=${P/fmr/FMR}
S=${WORKDIR}/${MY_P}
DESCRIPTION="radio tuner Plugin for XMMS"
HOMEPAGE="http://silicone.free.fr/xmms-FMRadio/"
SRC_URI="http://silicone.free.fr/xmms-FMRadio/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64"

RDEPEND="media-sound/xmms"

src_compile() {
	emake || die
}

src_install() {
	make PREFIX=${D}/usr install || die
	dodoc INSTALL README
}
