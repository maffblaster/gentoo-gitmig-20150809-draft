# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rdiff-backup/rdiff-backup-0.12.4.ebuild,v 1.3 2003/10/16 20:43:54 mholzer Exp $

inherit distutils

S=${WORKDIR}/${P}
DESCRIPTION="Remote incremental file backup utility, similar to rsync but more reliable"
SRC_URI="http://rdiff-backup.stanford.edu/${P}.tar.gz"
HOMEPAGE="http://rdiff-backup.stanford.edu"
LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"
SLOT="0"

RDEPEND=">=net-libs/librsync-0.9.6"

src_compile() {
	distutils_src_compile
}

src_install() {
	distutils_src_install
}
