# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-misc/asr-manpages/asr-manpages-1.3_rc5.ebuild,v 1.2 2004/02/20 06:43:58 mr_bones_ Exp $

MY_R="5"
MY_P="${PN}_${PV/_rc5/}"
DESCRIPTION="set of humorous manual pages developed on alt.sysadmin.recovery"
HOMEPAGE="http://debian.org/"
SRC_URI="http://ftp.debian.org/debian/pool/main/a/asr-manpages/${MY_P}.orig.tar.gz
	http://ftp.debian.org/debian/pool/main/a/asr-manpages/${MY_P}-${MY_R}.diff.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc"

RDEPEND="sys-apps/man"

S="${WORKDIR}/${MY_P/_/-}.orig"

src_unpack() {
	unpack ${A}
	patch -p0 < ${MY_P}-${MY_R}.diff || die
}

src_install() {
	rm -rf debian
	doman *
}
