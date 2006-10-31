# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netperf/netperf-2.4.2.ebuild,v 1.1 2006/10/31 23:18:10 jokey Exp $

WANT_AUTOCONF="latest"
inherit eutils flag-o-matic autotools

MY_P=${P/_rc/-rc}

DESCRIPTION="Network performance benchmark including tests for TCP, UDP, sockets, ATM and more."
#SRC_URI="ftp://ftp.netperf.org/netperf/experimental/${MY_P}.tar.gz"
SRC_URI="ftp://ftp.netperf.org/netperf/${MY_P}.tar.gz"
KEYWORDS="~x86 ~sparc ~ia64 ~alpha ~amd64 ~ppc64 ~ppc ~ppc-macos"

HOMEPAGE="http://www.netperf.org/"
LICENSE="netperf"
SLOT="0"
IUSE=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.4.0-gcc41.patch
	eautoconf
}

src_install () {
	einstall || die

	# move netserver into sbin as we had it before 2.4 was released with its
	# autoconf goodness
	dodir /usr/sbin
	mv ${D}/usr/{bin,sbin}/netserver || die

	# init.d / conf.d
	newinitd ${FILESDIR}/${PN}-2.2-init netperf
	newconfd ${FILESDIR}/${PN}-2.2-conf netperf

	# documentation and example scripts
	dodoc AUTHORS ChangeLog COPYING NEWS README Release_Notes doc/netperf.pdf
	dodir /usr/share/doc/${PF}/examples
	mv ${D}/usr/bin/*_script ${D}/usr/share/doc/${PF}/examples
}
