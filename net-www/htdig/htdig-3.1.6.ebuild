# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/htdig/htdig-3.1.6.ebuild,v 1.1 2002/04/15 11:12:07 seemant Exp ${PN}/${PN}-3.1.5-r2.ebuild,v 1.2 2002/03/15 12:10:18 danarmak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="HTTP/HTML indexing and searching system"
SRC_URI="http://www.htdig.org/files/${P}.tar.gz"
HOMEPAGE="http://www.htdig.org"

DEPEND=">=sys-libs/zlib-1.1.3
	app-arch/unzip"

src_compile() {

cd ${S}
	./configure \
		--prefix=/usr \
		--with-config-dir=/etc/${PN} \
		--with-image-dir=/home/httpd/htdocs/${PN} \
		--with-search-dir=/home/httpd/htdocs/${PN} \
		--with-cgi-bin-dir=/home/httpd \
		--with-common-dir=/usr/share/${PN} \
		--with-database-dir=/var/${PN} \
		--with-image-dir=/home/httpd/images/${PN} \
		--with-search-dir=/home/httpd/htdocs/${PN} \
		--with-default-config-file=/etc/${PN}/${PN}.conf \
		|| die

	emake || die

}

src_install () {

	make 	\
		DESTDIR=${D} 	\
		CONFIG_DIR=${D}/etc/${PN} \
		IMAGE_DIR=${D}/home/httpd/htdocs/${PN} \
		SEARCH_DIR=${D}/home/httpd/htdocs/${PN} \
		CGIBIN_DIR=${D}/home/httpd \
		COMMON_DIR=${D}/usr/share/${PN} \
		DATABASE_DIR=${D}/var/${PN} \
		IMAGE_DIR=${D}/home/httpd/images/${PN} \
		SEARCH_DIR=${D}/home/httpd/htdocs/htdig \
		DEFAULT_CONFIG_FILE=${D}/etc/${PN}/${PN}.conf \
		exec_prefix=${D}/usr/bin \
		install || die
	
	dodoc ChangeLog COPYING README
	dohtml -r htdoc
	
	insinto /etc/conf.d
	doins installdir/htdig.conf
	
	dosed /etc/httpd/htdig.conf
	dosed /usr/bin/rundig
}
