# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/kmyfirewall/kmyfirewall-0.9.4.ebuild,v 1.6 2004/06/24 22:41:20 agriffis Exp $

inherit kde
need-kde 3

DESCRIPTION="Graphical KDE iptables configuration tool"
SRC_URI="mirror://sourceforge/$PN/$P.tar.bz2"
HOMEPAGE="http://kmyfirewall.sourceforge.net/"

LICENSE="GPL-2"
KEYWORDS="x86"

S="$WORKDIR/$P-r1" # no idea why
RDEPEND="${RDEPEND} net-firewall/iptables"
