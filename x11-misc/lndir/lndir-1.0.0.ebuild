# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lndir/lndir-1.0.0.ebuild,v 1.1 2005/12/17 22:00:40 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org lndir utility"
KEYWORDS="~x86"
RDEPEND=""
DEPEND="${RDEPEND}
		x11-proto/xproto"
