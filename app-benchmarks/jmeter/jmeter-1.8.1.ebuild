# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/jmeter/jmeter-1.8.1.ebuild,v 1.8 2004/02/26 05:17:17 zx Exp $

S=${WORKDIR}/${PN}-${PV}
P=jakarta-${PN}-${PV}
DOWNLOAD="v1.8/${P}.tgz"
DESCRIPTION="Load test and measure performance on HTTP/FTP services, and databases."
HOMEPAGE="http://jakarta.apache.org/jmeter/index.html"
SRC_URI="http://jakarta.apache.org/builds/jakarta-jmeter/release/${DOWNLOAD}"
DEPEND=">=dev-java/sun-jdk-1.3.1"
RDEPEND=">=dev-java/sun-jdk-1.3.1"
LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="x86 -sparc -ppc -alpha -mips -hppa"
IUSE="doc"

src_compile () {
	cd ${WORKDIR}/${P}
	epatch ${FILESDIR}/${PN}-${PV}-gentoo.diff
}

src_install () {
	cd ${WORKDIR}/${P}
	DIROPTIONS="--mode=0775"
	dodir /opt/${PN}
	cp -ar bin/ lib/ ${D}/opt/${PN}/
	dobin jmeter jmeter-server
	dodoc LICENSE README
	use doc && dohtml -r docs/*
}
