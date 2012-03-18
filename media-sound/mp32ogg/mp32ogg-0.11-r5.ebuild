# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mp32ogg/mp32ogg-0.11-r5.ebuild,v 1.8 2012/03/18 15:48:03 armin76 Exp $

EAPI=2
inherit eutils

DESCRIPTION="A perl script to convert MP3 files to Ogg Vorbis files."
HOMEPAGE="http://faceprint.com/code/"
SRC_URI="ftp://ftp.faceprint.com/pub/software/scripts/mp32ogg"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="media-sound/mpg123
	dev-perl/MP3-Info
	dev-perl/String-ShellQuote
	media-sound/vorbis-tools"
DEPEND=""

S=${WORKDIR}

src_unpack() {
	cp -f "${DISTDIR}"/${PN} "${WORKDIR}" || die "cp failed"
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-r4-mpg321.patch \
		"${FILESDIR}"/${P}-r4-quality.patch \
		"${FILESDIR}"/${PF}-german_umlaut.patch
}

src_install() {
	dobin mp32ogg || die "dobin failed"
}
