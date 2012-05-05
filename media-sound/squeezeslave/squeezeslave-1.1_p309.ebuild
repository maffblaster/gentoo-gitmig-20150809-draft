# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/squeezeslave/squeezeslave-1.1_p309.ebuild,v 1.2 2012/05/05 08:52:05 mgorny Exp $

EAPI="4"

inherit eutils toolchain-funcs

DESCRIPTION="A lightweight streaming audio player for squeezeboxserver"
HOMEPAGE="http://squeezeslave.googlecode.com"
SRC_URI="http://dev.gentoo.org/~radhermit/distfiles/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="aac +alsa display wma zones"

RDEPEND="media-libs/libmad
	media-libs/flac
	media-libs/libvorbis
	media-libs/libogg
	media-libs/portaudio[alsa?]
	aac? ( virtual/ffmpeg )
	wma? ( virtual/ffmpeg )
	display? ( app-misc/lirc )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	virtual/pkgconfig"

src_prepare() {
	for i in display aac wma zones ; do
		! use $i && sed -i -e "/$i/Id" Makefile
	done

	epatch "${FILESDIR}"/${P}-ffmpeg.patch

	tc-export CC AR RANLIB
}

src_install() {
	dobin bin/${PN}
	dodoc ChangeLog TODO

	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}
