# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/mythtv/mythtv-0.18.2_pre7882.ebuild,v 1.1 2005/12/26 09:15:30 cardoe Exp $

inherit eutils qt3 flag-o-matic debug

DESCRIPTION="Homebrew PVR project"
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa altivec arts debug dvb frontendonly ieee1394 jack joystick lcd lirc mmx nvidia vorbis opengl oss unichrome"

DEPEND=">=media-libs/freetype-2.0
	>=media-sound/lame-3.93.1
	|| ( (  x11-libs/libX11
		x11-libs/libXinerama
		x11-libs/libXv
		x11-libs/libXrandr )
	virtual/x11 )
	$(qt_min_version 3.3)
	dev-db/mysql
	alsa? ( >=media-libs/alsa-lib-0.9 )
	arts? ( kde-base/arts )
	dvb? ( media-libs/libdvb )
	jack? ( media-sound/jack-audio-connection-kit )
	lcd? ( app-misc/lcdproc )
	lirc? ( app-misc/lirc )
	nvidia? ( media-video/nvidia-glx )
	vorbis? ( media-libs/libvorbis )
	opengl? ( virtual/opengl )
	ieee1394? (	>=sys-libs/libraw1394-1.2.0
			sys-libs/libavc1394
			>=media-libs/libiec61883-1.0.0 )
	|| ( >=net-misc/wget-1.9.1 >=media-tv/xmltv-0.5.34 )
	!x11-base/xfree
	!<x11-base/xorg-x11-6.8"

S=${WORKDIR}/${PN}

MYTHTV_GROUPS="video,audio"

pkg_setup() {

	if ! built_with_use x11-libs/qt mysql ; then
		eerror "Qt is missing MySQL support. Please add"
		eerror "'mysql' to your USE flags, and re-emerge Qt."
		die "Qt needs MySQL support"
	fi

	if ! best_version x11-libs/libXv && ! built_with_use x11-base/xorg-x11 xv; then
		eerror "xorg-x11 is missing XV support. Please add"
		eerror "'xv' to your USE flags, and re-emerge xorg-x11."
		die "xorg-x11 needs XV support"
	fi

	if use nvidia; then
		echo
		ewarn "You enabled the 'nvidia' USE flag, you must have a GeForce 4 or"
		ewarn "greater to use this. Otherwise, you'll have crashes with MythTV"
		echo
	fi

	einfo
	einfo "This ebuild now uses a heavily stripped down version of your CFLAGS"
	einfo "Don't complain because your -momfg-fast-speed CFLAG is being stripped"
	einfo "Only additional CFLAG issues that will be addressed are for binary"
	einfo "package building."
	einfo
}

src_unpack() {
	unpack ${A}
	cd ${S}

	if [ $(get_libdir) != "lib" ] ; then
		sed -i -e "s:\$\${PREFIX}/lib/:\$\${PREFIX}/$(get_libdir)/:g" \
			-e "s:\$\${PREFIX}/lib$:\$\${PREFIX}/$(get_libdir):g" \
			${S}/{filters,libs}/*/*.pro || die
		sed -i -e "s:/lib/mythtv/:/$(get_libdir)/mythtv/:" \
			${S}/libs/libmyth/mythcontext.cpp || die
	fi
}

src_compile() {
	use unichrome && use nvidia && die "You can not have USE="unichrome" and USE="nvidia" at the same time. Must disable one or the other."
	local myconf="$(use_enable altivec)
		$(use_enable oss audio-oss)
		$(use_enable alsa audio-alsa)
		$(use_enable arts audio-arts)
		$(use_enable jack audio-jack)
		$(use_enable lirc)
		$(use_enable joystick joystick-menu)
		$(use_enable unichrome xvmc-vld)
		$(use_enable dvb)
		$(use_enable dvb dvb-eit)
		--dvb-path=/usr/include
		$(use_enable opengl opengl-vsync)
		$(use_enable vorbis vorbis)
		$(use_enable nvidia xvmc)
		$(use_enable ieee1394 firewire)
		--enable-xv
		--enable-xrandr
		--disable-directfb
		--enable-x11
		--enable-proc-opt"

	if use mmx || use amd64; then
		myconf="${myconf} --enable-mmx"
	else
		myconf="${myconf} --disable-mmx"
	fi

	if use debug; then
		myconf="${myconf} --compile-type=debug"
	else
		myconf="${myconf} --compile-type=release"
	fi

	## CFLAG cleaning so it compiles
	MARCH=$(get-flag "march")
	MTUNE=$(get-flag "mtune")
	MCPU=$(get-flag "mcpu")
	strip-flags
	filter-flags "-march=*" "-mtune=*" "-mcpu=*"
	filter-flags "-O" "-O?" "-Os"

	if [[ -n "${MARCH}" ]]; then
		myconf="${myconf} --arch=${MARCH}"
	fi
	if [[ -n "${MTUNE}" ]]; then
		myconf="${myconf} --tune=${MTUNE}"
	fi
	if [[ -n "${MCPU}" ]]; then
		myconf="${myconf} --cpu=${MCPU}"
	fi

	myconf="${myconf} --extra-cflags=${CFLAGS}"

	hasq distcc ${FEATURES} || myconf="${myconf} --disable-distcc"
	hasq ccache ${FEATURES} || myconf="${myconf} --disable-ccache"

	if use frontendonly; then
		##Backend Removal
		cd ${S}
		sed -e "s:CCONFIG linux backend:CCONFIG linux:" \
			-i 'configure' || die "Removal of mythbackend failed"
	fi

	# let MythTV come up with our CFLAGS. Upstream will support this
	CFLAGS=""
	CXXFLAGS=""
	econf ${myconf} || die "configure died"

	${QTDIR}/bin/qmake -o "Makefile" mythtv.pro || die "qmake failed"
	emake || die "emake failed"

}

src_install() {

	einstall INSTALL_ROOT="${D}" || die "install failed"
	dodoc AUTHORS COPYING FAQ UPGRADING README

	if ! use frontendonly; then
		insinto /usr/share/mythtv/database
		doins database/*

		exeinto /usr/share/mythtv
		doexe "${FILESDIR}"/mythfilldatabase.cron

		newinitd "${FILESDIR}"/mythbackend-0.18.2.rc mythbackend
		newconfd "${FILESDIR}"/mythbackend-0.18.2.conf mythbackend
	fi

	dobin "${FILESDIR}"/runmythfe

	ewarn "Want MythFrontend to always run? Add the following to your"
	ewarn "myth user. i.e. My user is mythtv"
	echo "crontab -e -u mythtv"
	echo "* * * * * /usr/bin/runmythfe &"
	ewarn "And you're all set."

	dodoc keys.txt docs/*.{txt,pdf}
	dohtml docs/*.html

	keepdir /var/log/mythtv
	chown -R mythtv "${D}"/var/log/mythtv
}

pkg_preinst() {
	enewuser mythtv -1 "-1" -1 ${MYTHTV_GROUPS} || die "Problem adding mythtv user"
	usermod -G ${MYTHTV_GROUPS} mythtv
}

pkg_postinst() {
	einfo "Want MythFrontend to alway run? Run the following:"
	echo "crontab -e -u mythtv"
	einfo "And add the following:"
	echo "* * * * * /usr/bin/runmythfe &"
	echo
	echo
	einfo "To always have MythBackend running and available run the following:"
	echo "rc-update add mythbackend default"
}
