# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/avidemux/avidemux-2.0.18.ebuild,v 1.5 2003/11/27 18:00:08 mholzer Exp $

IUSE="debug nls oggvorbis arts truetype alsa"
filter-flags "-funroll-loops"
filter-flags "-maltivec -mabi=altivec"
inherit eutils

MY_P=${P}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Great Video editing/encoding tool. New, gtk2 version"
HOMEPAGE="http://fixounet.free.fr/avidemux/"
SRC_URI="http://fixounet.free.fr/avidemux/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="x86 ~ppc"

DEPEND="virtual/x11
	media-sound/mad
	>=media-libs/a52dec-0.7.4
	>=media-sound/lame-3.93
	>=media-video/mjpegtools-1.6
	>=media-libs/xvid-0.9
	>=dev-libs/libxml2-2.5.7
	>=x11-libs/gtk+-2.2.1
	x86? ( >=media-libs/divx4linux-20030428 )
	x86? ( dev-lang/nasm )
	nls? ( >=sys-devel/gettext-0.11.2 )
	oggvorbis? ( >=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0 )
	arts? ( >=kde-base/arts-1.1.1 )
	truetype? ( >=media-libs/freetype-2.1.2 )
	alsa? ( >=media-libs/alsa-lib-0.9.1 )"
# media-sound/toolame is supported as well


src_compile() {
	# Fixes a possible automake error due to clock skew
	touch -r *

	cd ${S}/avidemux/mpeg2enc; epatch ${FILESDIR}/gcc2.patch; cd ${S}
	cd ${S}/avidemux/ADM_dialog; epatch ${FILESDIR}/resize_crash.patch; cd ${S}

	export WANT_AUTOCONF_2_5=1
	autoconf

	# invalid cast
	use ppc \
		&& sed -i -e '188s/const//g' avidemux/ADM_video/ADM_vidFont.cpp

	local myconf
	myconf="--with-gnu-ld --disable-warnings"

	# --enable-profile        creates profiling infos default=no
	# --enable-pch            enables precompiled header support
	#                         (currently only KCC) default=no
	# --enable-final          build size optimized apps
	#                         (experimental - needs lots of memory)
	# --disable-closure       don't delay template instantiation

	use debug && myconf="${myconf} --enable-debug=full"
	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die "configure failed"

	make || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog History README TODO
}

pkg_postinst() {

	if [ -n "`use pcc`" ]
	then
		echo
		einfo "OSS sound output may not work on ppc"
		einfo "If your hear only static noise, try"
		einfo "changing the sound device to ALSA or arts"
	fi
}
