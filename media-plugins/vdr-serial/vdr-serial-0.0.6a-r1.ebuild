# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-serial/vdr-serial-0.0.6a-r1.ebuild,v 1.1 2007/03/02 18:18:30 hd_brummy Exp $

inherit vdr-plugin

DESCRIPTION="VDR Plugin: attach some buttons with diodes to the serial port"
HOMEPAGE="http://www.lf-klueber.de/vdr.htm"
SRC_URI="http://www.lf-klueber.de/${P}.tgz
		mirror://vdrfiles/${PN}/${P}.tgz"

KEYWORDS="~x86 ~amd64"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.2.6"

pkg_setup() {
	vdr-plugin_pkg_setup

	if ! getent group uucp | grep -q vdr; then
		echo
		einfo "Add user 'vdr' to group 'uucp' for full user access to serial/ttyS* device"
		echo
		elog "User vdr added to group uucp"
		gpasswd -a vdr uucp
	fi
}
