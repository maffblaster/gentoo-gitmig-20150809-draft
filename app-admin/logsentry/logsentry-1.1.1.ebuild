# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/logsentry/logsentry-1.1.1.ebuild,v 1.10 2003/03/28 10:27:14 pvdabeel Exp $

DESCRIPTION="automatically monitor system logs and mail security violations on a periodic basis"
HOMEPAGE="http://www.psionic.com/products/logsentry.html/"
SRC_URI="http://www.psionic.com/downloads/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

RDEPEND="net-mail/mailx"

S=${WORKDIR}/logcheck-${PV}

src_compile() {
	einfo "compile and install mixed in the package makefile"
}

src_install() {
	dodir /usr/bin /etc/logcheck/tmp /etc/cron.hourly
	cp systems/linux/logcheck.sh{,.orig}
	sed -e 's:/usr/local/bin:/usr/bin:' \
		-e 's:/usr/local/etc:/etc/logcheck:' \
		systems/linux/logcheck.sh.orig > systems/linux/logcheck.sh
	cp Makefile{,.orig}
	sed -e "s:/usr/local/bin:${D}/usr/bin:" \
		-e "s:/usr/local/etc:${D}/etc/logcheck:" \
		Makefile.orig > Makefile
	make CFLAGS="${CFLAGS}" linux || die

	dodoc README* CHANGES CREDITS
	dodoc systems/linux/README.*

	cat << EOF > ${D}/etc/cron.hourly/logsentry.cron
#!/bin/sh
#
# Uncomment the following if you want 
# logsentry (logcheck) to run hourly
#
# this is part of the logsentry package
#
#

#/bin/sh /etc/logcheck/logcheck.sh
EOF
}

pkg_postinst() {
	einfo 
	einfo "uncomment the logwatch line in /etc/cron.hourly/logsentry.cron,"
	einfo "or add directly to root's crontab"
	einfo
}
