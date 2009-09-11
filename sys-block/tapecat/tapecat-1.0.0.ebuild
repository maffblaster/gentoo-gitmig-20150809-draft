# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/tapecat/tapecat-1.0.0.ebuild,v 1.6 2009/09/11 11:34:31 flameeyes Exp $

DESCRIPTION="tapecat is a tape utility used to describe the physical content of a tape."
HOMEPAGE="http://www.inventivetechnology.at/tapecat/"
SRC_URI="http://downloads.inventivetechnology.at/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""
DEPEND="sys-apps/file"
RDEPEND="${DEPEND}"

src_compile() {
	emake CFLAGS="${CFLAGS} -Wall -ansi"
}

src_install() {
	dobin tapecat
	doman tapecat.1
}
