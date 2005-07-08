# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/mopac7/mopac7-1.00.ebuild,v 1.1 2005/07/08 06:55:29 spyderous Exp $

inherit flag-o-matic

DESCRIPTION="Autotooled, updated version of a powerful, fast semi-empirical package"
HOMEPAGE="http://sourceforge.net/projects/mopac7/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
LICENSE="mopac7"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lang/f2c
	sys-devel/autoconf
	sys-devel/automake
	sys-devel/libtool"
RDEPEND="dev-lang/f2c"

src_compile() {
	libtoolize --copy --force

	# This is absolutely required to avoid odd errors on MAIN__() not existing
	# and to build the mopac7 binary, not just the library.
	einfo "Adding required LDFLAGS for configure"
	econf LDFLAGS="-Xlinker -defsym -Xlinker MAIN__=main" || die "econf failed"

	# We need the appended LDFLAGS to activate building of the mopac7 binary,
	# but they break the actual linking of it. Something's obviously broken.
	einfo "Removing LDFLAGS, as they break the build"
	sed -i "/^LDFLAGS/d" src/Makefile.in
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	sed -i "s:./src/mopac7:./mopac7:g" run_mopac7
	dobin run_mopac7 src/.libs/mopac7
	dodoc AUTHORS README ChangeLog
}
