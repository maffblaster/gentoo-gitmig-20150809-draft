# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-soup/gst-plugins-soup-0.10.15.ebuild,v 1.1 2009/08/23 07:30:38 leio Exp $

inherit gst-plugins-good

DESCRIPTION="GStreamer plugin for HTTP client sources"

KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/gstreamer-0.10.23
	>=media-libs/gst-plugins-base-0.10.23
	>=net-libs/libsoup-2.3.2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
