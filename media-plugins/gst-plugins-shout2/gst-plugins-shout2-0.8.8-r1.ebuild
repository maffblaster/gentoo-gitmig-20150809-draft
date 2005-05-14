# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-shout2/gst-plugins-shout2-0.8.8-r1.ebuild,v 1.1 2005/05/14 10:59:21 zaheerm Exp $

inherit gst-plugins

DESCRIPTION="Plug-in to send data to an icecast server using libshout2"

KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

DEPEND=">=media-libs/libshout-2.0"

src_unpack() {

	gst-plugins_src_unpack

	# fixes shout2
	cd ${S}/ext/shout2
	epatch ${FILESDIR}/${P}-name.patch

}
