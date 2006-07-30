# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-hyperpen/xf86-input-hyperpen-1.1.0.ebuild,v 1.6 2006/07/30 15:56:19 psi29a Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org driver for hyperpen input devices"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 ~mips ppc ppc64 sh sparc ~x86 ~x86-fbsd"
RDEPEND=">=x11-base/xorg-server-1.0.99"
DEPEND="${RDEPEND}
	x11-proto/inputproto
	x11-proto/randrproto
	x11-proto/xproto"
