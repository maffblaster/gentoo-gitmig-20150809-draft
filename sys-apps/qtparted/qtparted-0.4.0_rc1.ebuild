# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qtparted/qtparted-0.4.0_rc1.ebuild,v 1.2 2003/09/10 04:42:32 msterret Exp $

inherit kde
need-qt 3.1

MY_P=${P/_rc/-rc}
S=${WORKDIR}/${MY_P}

DESCRIPTION="QtParted is a nice Qt partition tool for Linux"
HOMEPAGE="http://qtparted.sourceforge.net"
SRC_URI="mirror://sourceforge/qtparted/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND=">=x11-libs/qt-3.1.0
	>=sys-apps/parted-1.6.6
	>=sys-apps/e2fsprogs-1.33
	>=dev-libs/progsreiserfs-0.3.0.4
	>=sys-apps/xfsprogs-2.3.9
	>=sys-apps/jfsutils-1.1.2
	>=sys-apps/ntfsprogs-1.7.1"
