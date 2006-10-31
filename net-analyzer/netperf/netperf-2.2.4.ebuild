# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/netperf/netperf-2.2.4.ebuild,v 1.18 2006/10/31 23:18:10 jokey Exp $

inherit flag-o-matic

if [[ $PV == *.*.* ]]; then
	MY_P=${P%.*}pl${PV##*.}	# convert netperf-2.2.4 => netperf-2.2pl4
	S=${WORKDIR}/${MY_P}
else
	MY_P=${P}
fi

DESCRIPTION="Network performance benchmark including tests for TCP, UDP, sockets, ATM and more."
SRC_URI="ftp://ftp.netperf.org/netperf/archive/${MY_P}.tar.gz"
HOMEPAGE="http://www.netperf.org/"
LICENSE="netperf"
SLOT="0"
KEYWORDS="x86 sparc ia64 alpha amd64 ppc64 ~ppc ppc-macos"

IUSE="ipv6"

DEPEND="virtual/libc >=sys-apps/sed-4"

src_compile() {
	use ppc-macos || append-flags -DDO_UNIX
	use ipv6 && append-flags -DDO_IPV6
	emake CFLAGS="${CFLAGS}" || die
	sed -i 's:^\(NETHOME=\).*:\1/usr/bin:' *_script
}

src_install () {
	# binaries
	dosbin netserver
	dobin netperf

	# init.d / conf.d
	newinitd ${FILESDIR}/${PN}-2.2-init netperf
	newconfd ${FILESDIR}/${PN}-2.2-conf netperf

	# man pages
	newman netserver.man netserver.1
	newman netperf.man netperf.1

	# documentation and example scripts
	dodoc ACKNWLDGMNTS COPYRIGHT README Release_Notes netperf.ps
	dodir /usr/share/doc/${PF}/examples
	cp *_script ${D}/usr/share/doc/${PF}/examples
}
