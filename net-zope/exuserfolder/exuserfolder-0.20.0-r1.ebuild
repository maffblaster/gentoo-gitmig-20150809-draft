# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/exuserfolder/exuserfolder-0.20.0-r1.ebuild,v 1.2 2004/06/25 01:20:40 agriffis Exp $

inherit zproduct

DESCRIPTION="allows authentication via alternative methods + mysql plain text auth patch"
HOMEPAGE="http://exuserfolder.sf.net"
SRC_URI="http://www.gentoo.at/distfiles/exuserfolder-0.2-s2upatch.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"
RDEPEND="=net-zope/cmf-1.3*
	>=net-zope/formulator-1.2.0
	${RDEPEND}"

SLOT="0"

ZPROD_LIST="exUserFolder"
