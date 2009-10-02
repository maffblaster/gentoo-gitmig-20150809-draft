# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man-db/man-db-2.5.6.ebuild,v 1.1 2009/10/02 21:50:28 flameeyes Exp $

EAPI=2

inherit eutils autotools

DESCRIPTION="a man replacement that utilizes berkdb instead of flat files"
HOMEPAGE="http://www.nongnu.org/man-db/"
SRC_URI="http://download.savannah.nongnu.org/releases/man-db/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="berkdb +gdbm nls"

RDEPEND="berkdb? ( sys-libs/db )
	gdbm? ( sys-libs/gdbm )
	!berkdb? ( !gdbm? ( sys-libs/gdbm ) )
	|| ( sys-apps/groff >=app-doc/heirloom-doctools-080407-r2 )
	!sys-apps/man"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"
PROVIDE="virtual/man"

pkg_setup() {
	enewgroup man 15
	enewuser man 13 -1 /usr/share/man man
}

src_prepare() {
	epatch "${FILESDIR}"/${P}-fix-no-groff.patch

	eautoreconf
}

src_configure() {
	local db="gdbm"
	use berkdb && ! use gdbm && db="db"
	econf \
		--with-sections="1 1p 8 2 3 3p 4 5 6 7 9 0p tcl n l p o 1x 2x 3x 4x 5x 6x 7x 8x" \
		$(use_enable nls) \
		--with-db=${db} \
		|| die
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc README docs/{ChangeLog,HACKING,NEWS,TODO}
}
