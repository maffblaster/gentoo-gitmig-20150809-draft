# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/exo/exo-0.3.0_pre1.ebuild,v 1.1 2005/03/04 06:23:03 bcowan Exp $

DESCRIPTION="Extension library for Xfce"
HOMEPAGE="http://www.os-cillation.com/"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND=">=x11-libs/gtk+-2.4*
	>=sys-apps/dbus-0.22
	>=xfce-base/libxfce4mcs-4.2.0"
MY_P="${PN/t/T}-${PV/_/}"
BZIPPED=1
GOODIES=1

inherit xfce4
