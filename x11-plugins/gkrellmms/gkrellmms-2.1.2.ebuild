# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellmms/gkrellmms-2.1.2.ebuild,v 1.4 2002/12/09 04:41:57 manson Exp $

S=${WORKDIR}/${PN}
DESCRIPTION="A sweet plugin to control XMMS from GKrellM2"
SRC_URI="http://gkrellm.luon.net/files/${P}.tar.gz"
HOMEPAGE="http://gkrellm.luon.net/gkrellmms.phtml"

DEPEND=">=app-admin/gkrellm-2*
	media-sound/xmms"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc "

src_compile() {
	emake || die
}

src_install () {
	exeinto /usr/lib/gkrellm2/plugins
	newexe gkrellmms.so gkrellmms2.so
	dodoc README Changelog FAQ Themes
}
