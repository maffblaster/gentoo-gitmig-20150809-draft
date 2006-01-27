# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/qpage/qpage-3.3.ebuild,v 1.9 2006/01/27 16:58:38 chutzpah Exp $

inherit eutils

DESCRIPTION="Sends messages to an alphanumeric pager via TAP protocol."
HOMEPAGE="http://www.qpage.org/"
SRC_URI="http://www.qpage.org/download/${P}.tar.Z"

LICENSE="qpage"
SLOT="0"
KEYWORDS="~alpha ~amd64 x86"
IUSE="tcpd"

DEPEND="tcpd? ( sys-apps/tcp-wrappers )"
RDEPEND="${DEPEND}
	virtual/mta"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${P}-gentoo.patch
	epatch ${FILESDIR}/${P}-fix-warning.patch
}

src_compile() {
	econf || die "econf failed"

	# There doesn't seem to be a clean way to disable tcp wrappers in
	# this package if you have it installed, but don't want to use it.
	if ! use tcpd ; then
		sed -i 's/-lwrap//g; s/-DTCP_WRAPPERS//g' Makefile
		echo '#undef TCP_WRAPPERS' >> config.h
	fi

	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"

	dodir /var/spool/qpage
	fowners daemon:daemon /var/spool/qpage
	fperms 770 /var/spool/qpage

	dodir /var/lock/subsys/qpage
	fowners daemon:daemon /var/lock/subsys/qpage
	fperms 770 /var/lock/subsys/qpage

	insinto /etc/qpage
	doins example.cf || die "doins example.cf failed"

	doinitd "${FILESDIR}"/qpage
}

pkg_postinst() {
	einfo
	einfo "Post-installation tasks:"
	einfo
	einfo "1. Create /etc/qpage/qpage.cf (see example.cf in that dir)."
	einfo "2. Insure that the serial port selected in qpage.cf"
	einfo "   is writable by user or group daemon."
	einfo "3. Set automatic startup with rc-update add qpage default"
	einfo "4. Send mail to tomiii@qpage.org telling him how"
	einfo "   you like qpage! :-)"
	einfo
}
