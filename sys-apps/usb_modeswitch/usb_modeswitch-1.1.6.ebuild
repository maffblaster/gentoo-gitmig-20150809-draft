# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usb_modeswitch/usb_modeswitch-1.1.6.ebuild,v 1.1 2011/02/12 18:15:49 rafaelmartins Exp $

EAPI="2"
inherit multilib toolchain-funcs

MY_PN="${PN/_/-}"
MY_P="${MY_PN}-${PV}"
DATA_VER="20101222"

DESCRIPTION="USB_ModeSwitch is a tool for controlling 'flip flop' (multiple devices) USB gear like UMTS sticks"
HOMEPAGE="http://www.draisberghof.de/usb_modeswitch/"
SRC_URI="http://www.draisberghof.de/${PN}/${MY_P}.tar.bz2
	http://www.draisberghof.de/${PN}/${MY_PN}-data-${DATA_VER}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="virtual/libusb:0"
RDEPEND="${DEPEND}
	dev-lang/tcl" # usb_modeswitch script is tcl

S="${WORKDIR}/${MY_P}"

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	local udevdir="${D}/$(get_libdir)/udev"
	emake DESTDIR="${D}" UDEVDIR="${udevdir}" install || die

	cd ../"${MY_PN}-data-${DATA_VER}"
	emake DESTDIR="${D}" RULESDIR="${udevdir}/rules.d" files-install db-install \
		|| die 'emake install failed.d'
}
