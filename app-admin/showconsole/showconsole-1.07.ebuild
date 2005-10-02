# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/showconsole/showconsole-1.07.ebuild,v 1.9 2005/10/02 11:23:23 agriffis Exp $

inherit eutils toolchain-funcs

DESCRIPTION="small daemon for logging console output during boot"
HOMEPAGE="http://www.novell.com/linux/suse/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	mirror://gentoo/${P}-suse-update.patch.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 ppc ~sparc x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${P}.tar.bz2
	cd "${S}"
	epatch "${DISTDIR}"/${P}-suse-update.patch.bz2
	epatch "${FILESDIR}"/${PV}-no-TIOCGDEV.patch
}

src_compile() {
	emake COPTS="${CFLAGS}" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	insinto /$(get_libdir)/rcscripts/addons
	doins "${FILESDIR}"/bootlogger.sh || die "rcscript addon"
	rmdir "${D}"/usr/lib/lsb
	dodoc showconsole-1.07.lsm README
}
