# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/automake/automake-1.6.3.ebuild,v 1.20 2004/11/14 03:49:01 vapier Exp $

inherit eutils gnuconfig

DESCRIPTION="Used to generate Makefile.in from Makefile.am"
HOMEPAGE="http://sources.redhat.com/automake/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="${PV:0:3}"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="uclibc"

DEPEND="dev-lang/perl
	sys-devel/automake-wrapper
	>=sys-devel/autoconf-2.58
	sys-devel/gnuconfig"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i \
		-e "/^@setfilename/s|automake|automake${SLOT}|" \
		-e "s|automake: (automake)|automake v${SLOT}: (automake${SLOT})|" \
		-e "s|aclocal: (automake)|aclocal v${SLOT}: (automake${SLOT})|" \
		automake.texi || die "sed failed"
	gnuconfig_update
}

src_install() {
	make DESTDIR="${D}" install || die
	rm -f "${D}"/usr/bin/{aclocal,automake}

	dodoc NEWS README THANKS TODO AUTHORS ChangeLog
	doinfo *.info

	# remove all config.guess and config.sub files replacing them
	# w/a symlink to a specific gnuconfig version
	local x=
	for x in guess sub ; do
		dosym ../gnuconfig/config.${x} /usr/share/${PN}-${SLOT}/config.${x}
	done
}

pkg_postinst() {
	einfo "Please note that the 'WANT_AUTOMAKE_1_6=1' syntax has changed to:"
	einfo "  WANT_AUTOMAKE=1.6"
}
