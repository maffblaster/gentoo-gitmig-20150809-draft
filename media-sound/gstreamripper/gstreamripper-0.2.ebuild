# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/gstreamripper/gstreamripper-0.2.ebuild,v 1.6 2004/11/23 05:23:05 eradicator Exp $

IUSE=""

MY_PN="GStreamripperX"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="GStreamripper, a GTK front-end to streamripper"

HOMEPAGE="http://sourceforge.net/projects/gstreamripper/"
SRC_URI="mirror://sourceforge/gstreamripper/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~sparc x86"

DEPEND=">=x11-libs/gtk+-2.4*
	>=media-sound/streamripper-1.60.5"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
