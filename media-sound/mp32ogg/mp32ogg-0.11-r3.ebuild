# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp32ogg/mp32ogg-0.11-r3.ebuild,v 1.5 2004/07/12 08:05:50 eradicator Exp $

inherit eutils
IUSE=""

DESCRIPTION="A perl script to convert MP3 files to Ogg Vorbis files."

HOMEPAGE="http://faceprint.com/code/"
SRC_URI="ftp://ftp.faceprint.com/pub/software/scripts/mp32ogg"

LICENSE="Artistic"

SLOT="0"
KEYWORDS="x86 ~sparc ~amd64"

DEPEND=""
RDEPEND="virtual/mpg123
	dev-perl/MP3-Info
	dev-perl/String-ShellQuote
	media-sound/vorbis-tools"

S=${WORKDIR}/

src_unpack(){
	cp ${DISTDIR}/${A} ${S}
	epatch ${FILESDIR}/${PF}-mpg321.patch
}

src_install() {
	dobin mp32ogg
}
