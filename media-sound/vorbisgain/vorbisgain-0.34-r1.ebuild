# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/vorbisgain/vorbisgain-0.34-r1.ebuild,v 1.10 2004/09/15 19:41:54 eradicator Exp $

IUSE=""

DESCRIPTION="vorbisgain calculates a perceived sound level of an Ogg Vorbis file using the ReplayGain algorithm and stores it in the file header"
HOMEPAGE="http://users.pandora.be/sjeng/vorbisgain.html"
SRC_URI="http://sjeng.org/ftp/vorbis/${P}.zip"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="x86 amd64 sparc ~ppc ppc64"

DEPEND=">=media-libs/libvorbis-1.0
	app-arch/unzip"

src_compile() {
	chmod +x configure
	econf --enable-recursive || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
