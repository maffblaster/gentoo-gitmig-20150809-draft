# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mod_auth_mysql/mod_auth_mysql-20030510-r2.ebuild,v 1.1 2003/10/02 02:14:57 robbat2 Exp $

DESCRIPTION="Basic authentication for Apache using a MySQL database"
HOMEPAGE="http://modauthmysql.sourceforge.net/"

S=${WORKDIR}/${PN}
SRC_URI="mirror://sourceforge/modauthmysql/${PN}.tgz"
DEPEND="dev-db/mysql
		net-www/apache
		apache2? ( >=net-www/apache-2* )"
LICENSE="Apache-1.1"
KEYWORDS="~x86"
IUSE="apache2"
SLOT="0"

if use apache2 ; then
	APXS="apxs2 -D APACHE2"
	DESTDIR=/usr/lib/apache2-extramodules
	CONFDIR=/etc/apache2/conf/modules.d
else
	APXS="apxs -D APACHE1"
	DESTDIR=/usr/lib/apache-extramodules
	CONFDIR=/etc/apache/conf/addon-modules
fi

src_compile() {
	$APXS -c ${PN}.c -I/usr/include/mysql -lmysqlclient -lm -lz || die
}

src_install() {
	exeinto ${DESTDIR}
	doexe .libs/${PN}.so
	insinto ${CONFDIR}
	doins ${FILESDIR}/12_mod_auth_mysql.conf
	cat mod_auth_mysql.c | head -81 \
		| cut -c 4- > mod_auth_mysql.txt
	dodoc ${FILESDIR}/12_mod_auth_mysql.conf \
		README mod_auth_mysql.txt
}

pkg_postinst() {
	if use apache2; then
		einfo "Please add '-D AUTH_MYSQL' to your /etc/conf.d/apache2 APACHE2_OPTS setting"
	else
		einfo "Please add '-D AUTH_MYSQL' to your /etc/conf.d/apache APACHE_OPTS setting"
	fi
}
