# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: System Team <system@gentoo.org>
# Author: Achim Gottinger <achim@gentoo.org>, Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/sys-libs/pam/pam-0.75-r2.ebuild,v 1.1 2002/02/18 00:48:06 blocke Exp $

P=pam-${PV}
A=Linux-PAM-${PV}.tar.gz
S=${WORKDIR}/Linux-PAM-${PV}
DESCRIPTION="Pluggable Authentication Modules"
SRC_URI="http://www.kernel.org/pub/linux/libs/pam/pre/library/${A} http://cvs.gentoo.org/~blocke/pam-${PV}-${PR}-gentoo.diff.gz" 
HOMEPAGE="http://www.redhat.com/linux-info/pam/"

DEPEND=">=sys-libs/cracklib-2.7-r2 >=sys-libs/pwdb-0.61-r3 berkdb? ( ~sys-libs/db-1.85 ) sys-apps/gzip"

src_unpack() {
	tar xvzf ${DISTDIR}/Linux-PAM-${PV}.tar.gz
	zcat ${DISTDIR}/pam-${PV}-${PR}-gentoo.diff.gz | patch -p0
}


src_compile() {
	./configure --prefix= --host=${CHOST} --sbindir=/usr/sbin --mandir=/usr/share/man --enable-fakeroot=${D} --enable-read-both-confs || die
	cp Makefile Makefile.orig
	sed -e "s:libpam_misc doc examples:libpam_misc:" Makefile.orig > Makefile
	cp Make.Rules Make.orig
	sed -e "s:/usr/bin/install:/bin/install:" -e "s:-Wpointer-arith::" -e "s:^CFLAGS=:CFLAGS=${CFLAGS} :" Make.orig > Make.Rules
	if [ -z "`use berkdb`" ]
	then
		cp Make.Rules Make.orig
		sed -e "s:^HAVE_LIBNDBM=yes:HAVE_LIBNDBM=no:" Make.orig > Make.Rules
	fi
	make || die
	cd doc
	tar xvzf Linux-PAM-0.75-docs.tar.gz
}

src_install() {
	make install MANDIR="/usr/share/man" || die
	dodoc CHANGELOG Copyright README
	docinto modules
	dodoc modules/README
	cd modules
	for i in pam_*
	do
		if [ -f $i/README ]
		then
			docinto modules/$i
			dodoc $i/README
		fi
	done

	cd ..
	docinto html
	dodoc doc/html/*.html
	docinto txt
	dodoc doc/txts/*.txt doc/specs/*.txt
	docinto print
	dodoc doc/ps/*.ps


	cd ${D}/lib
	for i in pam pamc pam_misc
	do
		rm lib${i}.so
		ln -s lib${i}.so.${PV} lib${i}.so
		ln -s lib${i}.so.${PV} lib${i}.so.0
	done

	dodir /etc/pam.d
	#install /etc/pam.d files
	cd ${FILESDIR}/pam.d
	insinto /etc/pam.d
	doins *
}

