# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/guidedog/guidedog-1.0.0.ebuild,v 1.2 2004/05/12 15:14:44 dholm Exp $

inherit kde-base || die

need-kde 3

DESCRIPTION="A network/routing configuration utility for KDE 3"
SRC_URI="http://www.simonzone.com/software/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.simonzone.com/software/guidedog/"
KEYWORDS="~x86 ~ppc"
LICENSE="GPL-2"
SLOT="0"
IUSE=""

newdepend ">=net-firewall/iptables-1.2.5"

