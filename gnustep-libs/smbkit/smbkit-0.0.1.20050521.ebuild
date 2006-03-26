# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-libs/smbkit/smbkit-0.0.1.20050521.ebuild,v 1.4 2006/03/26 12:03:00 grobian Exp $

inherit gnustep

DESCRIPTION="SMBKit offers a samba library and headers for GNUstep."
HOMEPAGE="http://www.gnustep.org"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

KEYWORDS="~ppc ~x86"
LICENSE="GPL-2 LGPL-2.1"
SLOT="0"

IUSE=""
DEPEND="${GS_DEPEND}
	net-fs/samba"
RDEPEND="${GS_RDEPEND}
	net-fs/samba"

egnustep_install_domain "System"
