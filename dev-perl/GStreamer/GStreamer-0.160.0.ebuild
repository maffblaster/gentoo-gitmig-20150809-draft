# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GStreamer/GStreamer-0.160.0.ebuild,v 1.2 2012/05/04 04:10:56 jdhore Exp $

EAPI=4

MODULE_AUTHOR=TSCH
MODULE_VERSION=0.16
inherit perl-module

DESCRIPTION="Perl bindings for GStreamer"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

RDEPEND="=media-libs/gstreamer-0.10*
	>=dev-perl/glib-perl-1.180"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-depends-0.205
	>=dev-perl/extutils-pkgconfig-1.07
	virtual/pkgconfig"
