# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/bopm/bopm-3.1.2.ebuild,v 1.3 2004/07/01 20:47:03 squinky86 Exp $

inherit eutils

DESCRIPTION="Blitzed Open Proxy Monitor"
HOMEPAGE="http://www.blitzed.org/bopm/"
SRC_URI="http://static.blitzed.org/www.blitzed.org/${PN}/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	sys-apps/sed"

src_compile() {
	econf \
		--sysconfdir=/etc \
		--datadir=/usr/share/doc/${PF} \
		--localstatedir=/var/log/bopm || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	sed -i \
		-e 's!/some/path/bopm.pid!/var/run/bopm/bopm.pid!' \
		-e 's!/some/path/scan.log!/var/log/bopm/scan.log!' bopm.conf.sample

	make \
		DESTDIR=${D} \
		sysconfdir=${D}/etc \
		datadir=/usr/share/doc/${PF} \
		localstatedir=${D}/var/log/bopm \
		install || die "install failed"

	fperms 600 /etc/bopm.conf

	# Remove libopm related files, because bopm links statically to it
	# If anybody wants libopm, please install net-libs/libopm
	rm -r ${D}/usr/lib ${D}/usr/include

	exeinto /etc/init.d
	newexe ${FILESDIR}/bopm.init.d bopm
	insinto /etc/conf.d
	newins ${FILESDIR}/bopm.conf.d bopm

	dodoc CREDITS ChangeLog INSTALL LICENSE README TODO
}

pkg_postinst() {
	enewuser bopm

	install -d -m 0700 -o bopm -g root ${ROOT}/var/log/bopm
	install -d -m 0700 -o bopm -g root ${ROOT}/var/run/bopm
	chown bopm ${ROOT}/etc/bopm.conf
}
