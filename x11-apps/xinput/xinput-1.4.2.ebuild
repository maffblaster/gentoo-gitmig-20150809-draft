# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/xinput/xinput-1.4.2.ebuild,v 1.5 2009/10/09 20:48:39 maekke Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="Utility to set XInput device parameters"
LICENSE="as-is"
KEYWORDS="alpha amd64 arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXext
	>=x11-libs/libXi-1.2"
DEPEND="${RDEPEND}
	>=x11-proto/inputproto-1.5"
