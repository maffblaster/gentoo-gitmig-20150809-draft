# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.3.1.ebuild,v 1.10 2004/12/18 22:43:55 corsair Exp $

inherit kde-dist eutils

DESCRIPTION="KDE educational apps"

KEYWORDS="x86 amd64 sparc ppc ppc64 ~hppa alpha"
IUSE=""

src_unpack() {
	#kde_src_unpack
	# Workaround problem on JFS filesystems, see bug 62510
	bzip2 -dc ${DISTDIR}/${A} | tar xf -
	cd ${S}
}
