# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdc1394/libdc1394-2.0.0_pre5.ebuild,v 1.3 2006/01/29 08:02:28 robbat2 Exp $

inherit eutils

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="library for controling IEEE 1394 conforming based cameras"
HOMEPAGE="http://sourceforge.net/projects/libdc1394/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="X"

RDEPEND=">=sys-libs/libraw1394-0.9.0
		X? ( || ( ( x11-libs/libSM x11-libs/libXv )
				  virtual/x11 ) )"
DEPEND="${RDEPEND}
		sys-devel/libtool"

src_unpack() {
	unpack ${A}
	cd "${S}"

	if ! use X; then
		epatch ${FILESDIR}/nox11-2.patch
	fi

}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc NEWS README AUTHORS ChangeLog
}
