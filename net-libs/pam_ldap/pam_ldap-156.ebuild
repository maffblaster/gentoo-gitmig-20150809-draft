# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/pam_ldap/pam_ldap-156.ebuild,v 1.11 2005/02/05 11:03:31 hansmi Exp $

DESCRIPTION="PAM LDAP Module"
HOMEPAGE="http://www.padl.com/OSS/pam_ldap.html"
SRC_URI="ftp://ftp.padl.com/pub/${P}.tar.gz"

LICENSE="|| ( GPL-2 LGPL-2 )"
SLOT="0"
KEYWORDS="x86 sparc amd64 ppc"
IUSE=""

DEPEND=">=sys-libs/glibc-2.1.3
	>=sys-libs/pam-0.72
	>=net-nds/openldap-1.2.11"

src_compile() {
	aclocal
	autoconf
	automake --add-missing

	econf --with-ldap-lib=openldap || die
	emake || die
}

src_install() {

	exeinto /lib/security
	doexe pam_ldap.so

	dodoc pam.conf ldap.conf
	dodoc ChangeLog COPYING.* CVSVersionInfo.txt README
	docinto pam.d
	dodoc pam.d/*
}
