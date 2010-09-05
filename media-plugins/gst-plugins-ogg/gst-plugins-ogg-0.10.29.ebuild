# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-ogg/gst-plugins-ogg-0.10.29.ebuild,v 1.7 2010/09/05 14:19:58 armin76 Exp $

inherit gst-plugins-base

KEYWORDS="~alpha amd64 arm hppa ia64 ~ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=media-libs/libogg-1.0"
DEPEND="${RDEPEND}"
