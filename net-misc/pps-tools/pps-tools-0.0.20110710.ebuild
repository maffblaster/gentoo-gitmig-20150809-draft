# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/pps-tools/pps-tools-0.0.20110710.ebuild,v 1.1 2011/07/11 04:29:38 robbat2 Exp $

EAPI=3

inherit eutils

GITHUB_USER="ago"
PV_COMMIT="74c32c318f63bca5b5db"

DESCRIPTION="User-space tools for LinuxPPS"
HOMEPAGE="http://wiki.enneenne.com/index.php/LinuxPPS_installation"
SRC_URI="http://github.com/${GITHUB_USER}/${PN}/tarball/${PV_COMMIT} -> ${PN}-git-${PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${GITHUB_USER}-${PN}-${PV_COMMIT:0:7}"

src_prepare() {
	sed -i \
		-e '/^CFLAGS.*ggdb/d' \
		-e '/^CFLAGS.*O2/s,-O2,,g' \
		-e '/^\.PHONY:/s,all,,g' \
	Makefile
}

src_compile() {
	emake depend
	emake all
}

src_install() {
	dodir /usr/bin /usr/include
	emake install DESTDIR="${D}"
}
