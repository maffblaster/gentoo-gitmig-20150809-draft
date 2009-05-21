# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libmms/gst-plugins-libmms-0.10.11.ebuild,v 1.6 2009/05/21 15:36:31 ranger Exp $

inherit gst-plugins-bad

KEYWORDS="alpha amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND=">=media-libs/gst-plugins-base-0.10.22
	>=media-libs/gstreamer-0.10.22
	>=media-libs/libmms-0.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
