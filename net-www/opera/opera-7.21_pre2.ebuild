# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/opera/opera-7.21_pre2.ebuild,v 1.2 2003/10/11 20:18:39 lanius Exp $

# Here, like in the other .ebuilds, the static version is
# forced for simplicity's sake

DESCRIPTION="Opera web browser."
HOMEPAGE="http://www.opera.com/linux/"
LICENSE="OPERA"
IUSE="gnome kde"

# Dependencies may be augmented later (see below).
DEPEND=">=sys-apps/sed-4"

RDEPEND="virtual/x11
	>=media-libs/fontconfig-2.1.94-r1
	media-libs/libexif
	>=x11-libs/lesstif-0.93.40" #lesstif resolves Bug 25767

KEYWORDS="~x86 ~ppc ~sparc"
SLOT="0"

OPERAVER="7.21-20031003"
OPERATYPE="1-static-qt"

SRC_URI="x86? ( http://snapshot.opera.com/unix/7.21-Preview-2/intel-linux/${PN}-${OPERAVER}.${OPERATYPE}.i386.tar.bz2 )
	ppc? ( http://snapshot.opera.com/unix/7.21-Preview-2/ppc-linux/${PN}-${OPERAVER}.${OPERATYPE}.ppc.tar.bz2 )
	sparc? ( http://snapshot.opera.com/unix/7.21-Preview-2/sparc-linux/${PN}-${OPERAVER}.${OPERATYPE}.sparc.tar.bz2 )"

S=${WORKDIR}/${A/.tar.bz2/}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:/etc:${D}/etc:g" \
	       -e "s:config_dir=\"/etc\":config_dir=\"${D}/etc/\":g" \
	       -e "s:read install_config:install_config=yes:" \
	       -e "s:/opt/kde2:${D}/usr/kde/2:g" \
	       -e "s:/opt/kde2:${D}/usr/kde/2:g" \
	       -e "s:/usr/share/applnk:${D}/usr/share/applnk:g" \
	       -e "s:/usr/share/pixmaps:${D}/usr/share/pixmaps:g" \
	       -e "s:/usr/share/icons:${D}/usr/share/icons:g" \
	       -e "s:/etc/X11:${D}/etc/X11:g" \
	       -e "s:/usr/share/gnome:${D}/usr/share/gnome:g" \
	       -e 's:#\(LD_PRELOAD=.*libawt.so\):\1:' \
	       -e 's:#\(OPERA_FORCE_JAVA_ENABLED=\):\1:' \
	       -e 's:#\(export LD_PRELOAD OPERA_FORCE_JAVA_ENABLED\):\1:' \
		   -e 's:chop "${DESTDIR}" "str_localdirexec"::' \
		   -e 's:chop "${DESTDIR}" "str_localdirshare"::' \
		   -e 's:chop "${DESTDIR}" "str_localdirplugin"::' \
		   -e 's:read str_answer:return 0:' \
	       install.sh || die
}

src_compile() {
	true
}

src_install() {
	# Prepare installation directories for Opera's installer script.
	dodir /etc
	if [ "`use kde`" ]
	then
		# Install stuff for KDE2, and then simply copy it over
		# into the KDE3 directories.
		dodir /usr/kde/2/share/icons/{locolor,hicolor}/{16x16,22x22,32x32,48x48}/apps
		dodir /usr/kde/2/share/applnk/Internet
	fi
	if [ "`use gnome`" ]
	then
		dodir /usr/share/gnome/pixmaps
		dodir /usr/share/gnome/apps/Internet
	fi

	# Opera's native installer.
	./install.sh --prefix="${D}"/opt/opera || die
	if [ "`use kde`" ]
	then
		cp -R ${D}/usr/kde/2 ${D}/usr/kde/3
	fi
	rm ${D}/opt/opera/share/doc/opera/help
	dosym /opt/share/doc/opera/help /opt/opera/share/opera/help

	dosed /opt/opera/bin/opera
	dosed /opt/opera/share/opera/java/opera.policy

	# Install the icons
	insinto /usr/share/icons /etc/X11/wmconfig /etc/X11/applnk/Internet \
		/usr/share/pixmaps
	doins images/opera.xpm

	# Install a symlink /usr/bin/opera
	dodir /usr/bin
	dosym /opt/opera/bin/opera /usr/bin/opera
}

pkg_postinst() {
	einfo "For localized language files take a look at:"
	einfo "http://www.opera.com/download/languagefiles/index.dml?platform=linux"
}
