# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/automake-wrapper/automake-wrapper-1.ebuild,v 1.14 2005/02/07 04:17:50 kumba Exp $

DESCRIPTION="wrapper for automake to manage multiple automake versions"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="=sys-devel/automake-1.4*
	=sys-devel/automake-1.5*
	=sys-devel/automake-1.6*
	=sys-devel/automake-1.7*
	=sys-devel/automake-1.8.5-r3
	=sys-devel/automake-1.9*"

S=${WORKDIR}

src_install() {
	exeinto /usr/lib/misc
	newexe ${FILESDIR}/am-wrapper-${PV}.sh am-wrapper.sh || die

	keepdir /usr/share/aclocal

	dodir /usr/bin
	local x=
	for x in aclocal automake ; do
		dosym ../lib/misc/am-wrapper.sh /usr/bin/${x}
	done
}
