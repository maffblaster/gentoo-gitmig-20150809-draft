# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fluxbox/fluxbox-9999.ebuild,v 1.5 2009/11/14 16:09:34 scarabeus Exp $

EAPI=2
inherit eutils git

IUSE="nls xinerama +truetype gnome +imlib +slit +toolbar vim-syntax"

DESCRIPTION="Fluxbox is an X11 window manager featuring tabs and an iconbar"

EGIT_REPO_URI="git://git.fluxbox.org/fluxbox.git"
SRC_URI=""
HOMEPAGE="http://www.fluxbox.org"

# Please note that USE="gnome" simply adds support for the respective
# protocol, and does not depend on external libraries. It does, however,
# make the binary a fair bit bigger, so we don't want to turn it on unless
# the user actually wants them.

RDEPEND="x11-libs/libXpm
	x11-libs/libXrandr
	xinerama? ( x11-libs/libXinerama )
	x11-apps/xmessage
	x11-libs/libXft
	truetype? ( media-libs/freetype )
	imlib? ( >=media-libs/imlib2-1.2.0[X] )
	vim-syntax? ( app-vim/fluxbox-syntax )
	!!<x11-themes/fluxbox-styles-fluxmod-20040809-r1
	!!<=x11-misc/fluxconf-0.9.9
	!!<=x11-misc/fbdesk-1.2.1"
DEPEND="nls? ( sys-devel/gettext )
	x11-proto/xextproto
	xinerama? ( x11-proto/xineramaproto )
	${RDEPEND}"
PROVIDE="virtual/blackbox"

SLOT="0"
LICENSE="MIT"
KEYWORDS=""

src_unpack() {
	git_src_unpack
}

src_prepare() {
	git_src_prepare
	cd "${S}"
	./autogen.sh

	# We need to be able to include directories rather than just plain
	# files in menu [include] items. This patch will allow us to do clever
	# things with style ebuilds.
	epatch "${FILESDIR}/gentoo_style_location-1.1.x.patch"

	# Add in the Gentoo -r number to fluxbox -version output.
	if [[ "${PR}" == "r0" ]] ; then
		suffix="gentoo"
	else
		suffix="gentoo-${PR}"
	fi
	sed -i \
		-e "s~\(__fluxbox_version .@VERSION@\)~\1-${suffix}~" \
		version.h.in || die "version sed failed"
}

src_configure() {
	econf \
		$(use_enable nls) \
		$(use_enable xinerama) \
		$(use_enable truetype xft) \
		$(use_enable gnome) \
		$(use_enable imlib imlib2) \
		$(use_enable slit ) \
		$(use_enable toolbar ) \
		--sysconfdir=/etc/X11/${PN} \
		--with-style=/usr/share/fluxbox/styles/Emerge \
		${myconf}
}

src_compile() {
	emake || die "make failed"

	ebegin "Creating a menu file (may take a while)"
	mkdir -p "${T}/home/.fluxbox" || die "mkdir home failed"
	MENUFILENAME="${S}/data/menu" MENUTITLE="Fluxbox ${PV}" \
		CHECKINIT="no. go away." HOME="${T}/home" \
		"${S}/util/fluxbox-generate_menu" -is -ds \
		|| die "menu generation failed"
	eend $?
}

src_install() {
	dodir /usr/share/fluxbox
	emake DESTDIR="${D}" STRIP="" install || die "install failed"
	dodoc README* AUTHORS TODO* ChangeLog NEWS

	dodir /usr/share/xsessions
	insinto /usr/share/xsessions
	doins "${FILESDIR}/${PN}.desktop"

	exeinto /etc/X11/Sessions
	newexe "${FILESDIR}/${PN}.xsession" fluxbox

	dodir /usr/share/fluxbox/menu.d

	# Styles menu framework
	dodir /usr/share/fluxbox/menu.d/styles
	insinto /usr/share/fluxbox/menu.d/styles
	doins "${FILESDIR}/styles-menu-fluxbox" || die
	doins "${FILESDIR}/styles-menu-commonbox" || die
	doins "${FILESDIR}/styles-menu-user" || die
}
