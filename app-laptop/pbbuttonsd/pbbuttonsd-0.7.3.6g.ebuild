# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/pbbuttonsd/pbbuttonsd-0.7.3.6g.ebuild,v 1.1 2006/01/22 06:55:12 josejx Exp $

inherit eutils linux-info flag-o-matic versionator

MY_P=$( replace_version_separator 3 '-' )

DESCRIPTION="Handles power management and special keys on laptops."
HOMEPAGE="http://pbbuttons.sf.net"
SRC_URI="ftp://ftp.berlios.de/pub/pbbuttons/${PN}-${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="acpi debug alsa oss ibam"

DEPEND=">=sys-apps/baselayout-1.8.6.12-r1"
RDEPEND="alsa? ( >=media-libs/alsa-lib-1.0 )"

S="${WORKDIR}/${PN}-${MY_P}"

src_compile() {
	# Fix crash bug on some systems
	replace-flags -O? -O1

	if ! linux_chkconfig_present INPUT_EVDEV ; then
		eerror "Please enable CONFIG_INPUT_EVDEV in your kernel"
		eerror "pbbuttonsd will not work without it."
		die "Kernel not compiled with CONFIG_INPUT_EVDEV support"
	fi

	if use x86; then
		if use acpi; then
			laptop=acpi
		else
			laptop=i386
		fi
	else
		laptop=powerbook
	fi

	econf laptop=$laptop \
		$(use_with debug) \
		$(use_with alsa) \
		$(use_with oss) \
		$(use_with ibam) \
		|| die "Sorry, failed to configure pbbuttonsd"
	emake || die "Sorry, failed to compile pbbuttonsd"
}

src_install() {
	dodir /etc/power
	make DESTDIR=${D} install || die "failed to install"
	exeinto /etc/init.d
	newexe ${FILESDIR}/pbbuttonsd.rc6 pbbuttonsd
	dodoc README
}

pkg_postinst() {
	if linux_chkconfig_module INPUT_EVDEV ; then
		ewarn "Ensure that the evdev kernel module is loaded otherwise"
		ewarn "pbbuttonsd won't work."
		einfo
	fi

	if use ppc ; then
		einfo "It's recommended that you let pbbuttonsd act as the low level"
		einfo "power manager instead of using pmud."
		einfo
	fi
	if use ibam; then
		einfo "To properly initialize the IBaM battery database, you will"
		einfo "need to perform a full discharge/charge cycle.  For more"
		einfo "details, please see the pbbuttonsd man page."
		einfo
	fi
	ewarn "Warning: the NoTapTyping option is unstable, see bug #86768."
}
