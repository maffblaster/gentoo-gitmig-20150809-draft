# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-reminder/gkrellm-reminder-2.0.0.ebuild,v 1.3 2003/09/06 05:45:17 msterret Exp $

S=${WORKDIR}/${P}
DESCRIPTION="a Reminder Plugin for GKrellM2"
SRC_URI="http://web.wt.net/~billw/gkrellm/Plugins/${P}.tar.gz"
HOMEPAGE="http://www.gkrellm.net/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="=app-admin/gkrellm-2*"

src_compile() {
	make || die
}

src_install () {
	insinto /usr/lib/gkrellm2/plugins
	doins reminder.so
	dodoc README ChangeLog COPYING
}
