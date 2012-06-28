# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXTrap/libXTrap-1.0.0-r1.ebuild,v 1.5 2012/06/28 14:56:41 jer Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="X.Org XTrap library"

KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXt
	x11-libs/libXext
	x11-proto/trapproto"
DEPEND="${RDEPEND}"
