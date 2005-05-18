# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/mini-xml/mini-xml-2.2.1.ebuild,v 1.1 2005/05/18 14:43:54 jnc Exp $

IUSE=""

inherit libtool flag-o-matic gnuconfig

MY_P=${P/mini-xml/mxml}

DESCRIPTION="Mini-XML is a small XML parsing library that you can use to read XML and XML-like data files in your application without requiring large non-standard libraries."
HOMEPAGE="http://www.easysw.com/~mike/mxml"
SRC_URI="http://ftp.easysw.com/pub/mxml/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
}

src_install() {
	make DSTROOT="${D}" install || die "install failed"
	dodoc ANNOUNCEMENT CHANGES README
}
