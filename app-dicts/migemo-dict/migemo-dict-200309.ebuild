# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/migemo-dict/migemo-dict-200309.ebuild,v 1.14 2004/10/23 08:17:20 mr_bones_ Exp $

IUSE=""

DESCRIPTION="Dictionary files for the Migemo and C/Migemo"
HOMEPAGE="http://openlab.ring.gr.jp/skk/dic.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
KEYWORDS="x86 alpha sparc ppc ia64 hppa amd64 ppc64 ppc-macos"
SLOT="0"

DEPEND=""

src_install() {
	insinto /usr/share/migemo
	doins migemo-dict
}
