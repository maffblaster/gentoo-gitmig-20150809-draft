# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvdread/libdvdread-4.1.3_p1168.ebuild,v 1.8 2010/04/26 20:48:48 maekke Exp $

EAPI="2"
WANT_AUTOCONF="2.5"
inherit eutils autotools multilib

DESCRIPTION="Library for DVD navigation tools"
HOMEPAGE="http://www.mplayerhq.hu/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~hppa ~ia64 ~mips ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE="+css"

DEPEND="!<=media-libs/libdvdnav-4.1.2
	css? ( media-libs/libdvdcss )"
RDEPEND="$DEPEND"

src_prepare() {
	elibtoolize
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS DEVELOPMENT-POLICY.txt ChangeLog TODO README || die
}
