# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apache/mod_depends/mod_depends-0.7.0_p200702041.ebuild,v 1.3 2008/01/31 17:28:02 hollow Exp $

inherit eutils apache-module

DESCRIPTION="An apache helper module for handling dependencies properly."
SRC_URI="http://upstream.rm-rf.in/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.outoforder.cc/projects/apache/mod_depends/"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

APACHE2_MOD_CONF="0.7/09_${PN}"
APACHE2_MOD_DEFINE="DEPENDS"

need_apache2

src_compile() {
	econf --with-apxs="${APXS}" || die "configure failed"
	emake || die "make failed"
}

src_install() {
	AP_INCLUDEDIR=$(${APXS} -q INCLUDEDIR)

	insinto ${AP_INCLUDEDIR}
	doins include/mod_depends.h || die

	mv -v src/.libs/{lib,}mod_depends.so

	apache-module_src_install
}

# vim:ts=4
