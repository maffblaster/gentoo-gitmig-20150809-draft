# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-wireless/at76c503a/at76c503a-0.14_beta1.ebuild,v 1.3 2007/05/09 18:48:00 genstef Exp $

inherit linux-mod

MY_P=at76_usb-${PV/_}
HOMEPAGE="http://developer.berlios.de/projects/at76c503a/"
SRC_URI="http://download.berlios.de/at76c503a/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND="net-wireless/atmel-firmware
		|| ( >=sys-fs/udev-096 >=sys-apps/hotplug-20040923 )
		>=net-wireless/wireless-tools-26-r1"
S=${WORKDIR}/${MY_P}

MODULE_NAMES="at76_usb(net:)"
BUILD_TARGETS="all"

CONFIG_CHECK="NET_RADIO"
NET_RADIO_ERROR="${P} requires support for Wireless LAN drivers (non-hamradio) & Wireless Extensions (CONFIG_NET_RADIO)."

pkg_setup() {
	linux-mod_pkg_setup
	BUILD_PARAMS="KERNEL_PATH=${KV_DIR}"
}

src_install() {
	linux-mod_src_install

	dodoc README CHANGELOG
}
