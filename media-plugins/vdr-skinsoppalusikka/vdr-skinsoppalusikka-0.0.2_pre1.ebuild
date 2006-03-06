# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-skinsoppalusikka/vdr-skinsoppalusikka-0.0.2_pre1.ebuild,v 1.1 2006/03/06 19:59:21 hd_brummy Exp $

RESTRICT="nomirror"

inherit vdr-plugin

MY_PV="${PV%_pre1}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Video Disk Recorder - Skin Plugin"
HOMEPAGE="http://www.saunalahti.fi/~rahrenbe/vdr/soppalusikka"
SRC_URI="http://www.saunalahti.fi/~rahrenbe/vdr/soppalusikka/files/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=media-video/vdr-1.3.27"

S=${WORKDIR}/skinsoppalusikka-${MY_PV}

PATCHES="${FILESDIR}/${P}.diff"

src_install() {
	vdr-plugin_src_install

	insinto "/usr/share/vdr/skinsoppalusikka/logos"
	doins "${S}/logos/*.xpm"

	insinto "/etc/vdr/themes"
	doins "${S}/themes/*.theme"
}
