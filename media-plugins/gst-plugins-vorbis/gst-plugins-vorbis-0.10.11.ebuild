# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-vorbis/gst-plugins-vorbis-0.10.11.ebuild,v 1.6 2007/01/31 19:14:20 corsair Exp $

inherit eutils gst-plugins-base

KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~ppc ppc64 ~sh sparc ~x86"
IUSE=""

RDEPEND=">=media-libs/libvorbis-1
	 >=media-libs/libogg-1
	 >=media-libs/gst-plugins-base-0.10.11"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"
