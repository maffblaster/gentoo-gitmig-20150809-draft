# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/pchar/pchar-1.5.ebuild,v 1.3 2006/11/01 21:15:57 chutzpah Exp $

inherit eutils autotools

DESCRIPTION="Internet bandwidth, latency, and loss of links analyzer."
HOMEPAGE="http://www.kitchenlab.org/www/bmah/Software/pchar/"
SRC_URI="http://www.kitchenlab.org/www/bmah/Software/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6 pcap snmp"

DEPEND=">=dev-libs/openssl-0.9.7
	snmp? ( net-analyzer/net-snmp )
	pcap? ( net-libs/libpcap )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-snmp.patch
}

src_compile() {
	eautoreconf

	econf --without-suid \
		$(use_with ipv6) \
		$(use_with snmp snmp /usr/lib) \
		$(use_with pcap)
}

src_install() {
	einstall
	dodoc FAQ CHANGES README
}
