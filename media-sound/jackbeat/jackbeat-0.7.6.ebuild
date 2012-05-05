# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/jackbeat/jackbeat-0.7.6.ebuild,v 1.2 2012/05/05 08:30:50 mgorny Exp $

EAPI=4

inherit eutils autotools

DESCRIPTION="An audio sequencer for Linux"
HOMEPAGE="http://www.samalyse.com/jackbeat/"
SRC_URI="http://www.samalyse.com/jackbeat/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="jack pulseaudio"

RDEPEND="dev-libs/glib:2
	>=dev-libs/libxml2-2.6:2
	gnome-base/libglade:2.0
	>=media-libs/liblo-0.22
	>=media-libs/libsamplerate-0.1.2
	>=media-libs/libsndfile-1.0.15
	media-libs/alsa-lib
	media-libs/portaudio
	jack? ( >=media-sound/jack-audio-connection-kit-0.101 )
	pulseaudio? ( >=media-sound/pulseaudio-0.9.10 )
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	>=x11-libs/gtk+-2.12:2
	x11-libs/pango"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-automagic-pulse.patch

	# Don't install license file
	sed -i -e "s:help::" pkgdata/Makefile.am

	eautoreconf
}

src_configure() {
	econf \
		$(use_with jack) \
		$(use_with pulseaudio pulse)
}
