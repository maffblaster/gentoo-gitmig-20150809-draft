# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/verve/verve-0.3.5.ebuild,v 1.3 2007/02/02 18:13:41 gustavoz Exp $

inherit xfce44

xfce44_beta
xfce44_goodies_panel_plugin

DESCRIPTION="Xfce4 command line panel plugin"

KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"
IUSE="dbus debug"

RDEPEND=">=xfce-extra/exo-0.3.1.11
	dev-libs/libpcre
	dbus? ( || ( >=dev-libs/dbus-glib-0.71
		( <sys-apps/dbus-1 >=sys-apps/dbus-0.60 ) ) )"

DEPEND="${RDEPEND}
	dev-util/intltool"
