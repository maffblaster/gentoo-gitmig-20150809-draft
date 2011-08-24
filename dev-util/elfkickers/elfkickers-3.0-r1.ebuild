# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/elfkickers/elfkickers-3.0-r1.ebuild,v 1.4 2011/08/24 19:25:04 maekke Exp $

EAPI="4"

inherit eutils toolchain-funcs

MY_PN=${PN/elf/ELF}-${PV}
S=${WORKDIR}/${MY_PN}

DESCRIPTION="collection of programs to manipulate ELF files: sstrip, rebind, elfls, elftoc"
HOMEPAGE="http://www.muppetlabs.com/~breadbox/software/elfkickers.html"
SRC_URI="http://www.muppetlabs.com/~breadbox/pub/software/${MY_PN}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

DEPEND="app-misc/pax-utils"
RDEPEND=""

src_prepare() {
	epatch "${FILESDIR}"/respect-CFLAGS-LDFLAGS.patch
	epatch "${FILESDIR}"/create-destdir-path.patch
	sed -i -e "s:^prefix = /usr/local:prefix = ${D}:" Makefile \
		|| die "sed failed"
}

src_compile() {
	emake CC=$(tc-getCC) all
}
