# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/graphlcd-base/graphlcd-base-0.1.9.ebuild,v 1.2 2011/10/07 18:56:38 hd_brummy Exp $

EAPI=4

inherit eutils flag-o-matic multilib

VERSION="501" #every bump, new version

DESCRIPTION="Graphical LCD Driver"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/graphlcd"
SRC_URI="http://projects.vdr-developer.org/attachments/download/${VERSION}/${P}.tgz"

KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE="g15"

DEPEND=""
RDEPEND="g15? ( app-misc/g15daemon )"

src_prepare() {
	sed -i Make.config -e "s:usr\/local:usr:" -e "s:FLAGS *=:FLAGS ?=:"
	epatch "${FILESDIR}/${PN}-0.1.5-nostrip.patch"

	sed -i glcdskin/Makefile -e "s:-shared:\$(LDFLAGS) -shared:"
}

src_install() {
	emake DESTDIR="${D}"/usr LIBDIR="${D}"/usr/$(get_libdir) install

	insinto /etc
	doins graphlcd.conf

	dodoc docs/*
}
