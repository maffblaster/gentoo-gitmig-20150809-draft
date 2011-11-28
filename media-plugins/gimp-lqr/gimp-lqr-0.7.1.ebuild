# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gimp-lqr/gimp-lqr-0.7.1.ebuild,v 1.4 2011/11/28 11:57:37 phajdan.jr Exp $

MY_P="${PN}-plugin-${PV}"

DESCRIPTION="Content-aware resizing for the GIMP"
HOMEPAGE="http://liquidrescale.wikidot.com/"
SRC_URI="http://liquidrescale.wikidot.com/local--files/en:download-page-sources/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="media-gfx/gimp
	media-libs/liblqr"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS BUGS ChangeLog NEWS README TODO || die
}
