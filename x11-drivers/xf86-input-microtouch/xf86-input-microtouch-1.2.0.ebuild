# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-microtouch/xf86-input-microtouch-1.2.0.ebuild,v 1.4 2009/04/06 20:15:47 bluebird Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"
XDPVER="4"

inherit x-modular

DESCRIPTION="MicroTouch input driver"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh sparc x86 ~x86-fbsd"
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	>=x11-proto/inputproto-1.4.1
	x11-proto/randrproto
	x11-proto/xproto"
