# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/bpmdetect/bpmdetect-0.6.1.ebuild,v 1.3 2012/05/05 08:10:30 mgorny Exp $

EAPI=2
inherit eutils multilib

DESCRIPTION="Automatic BPM detection utility"
HOMEPAGE="http://sourceforge.net/projects/bpmdetect"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/taglib
	media-libs/id3lib
	>=media-libs/fmod-4.25.07-r1:1
	x11-libs/qt-gui:4"
DEPEND="${RDEPEND}
	sys-apps/sed
	dev-util/scons
	virtual/pkgconfig"

S=${WORKDIR}/${PN}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc44_and_fmodex_path.patch
	sed -i -e "s:-O2:${CXXFLAGS}:" src/SConscript || die "sed failed"
}

src_configure() { :; }

src_compile() {
	export QTDIR="/usr/$(get_libdir)"
	scons prefix=/usr || die "scons failed"
}

src_install() {
	dobin build/${PN} || die "dobin failed"
	doicon src/${PN}-icon.png
	domenu src/${PN}.desktop
	dodoc authors readme todo
}
