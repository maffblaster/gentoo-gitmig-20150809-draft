# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/streamtuner-live365/streamtuner-live365-0.3.4.ebuild,v 1.9 2005/09/03 23:42:43 flameeyes Exp $

DESCRIPTION="A plugin for Streamtuner that provides support for live365 streams."
SRC_URI="http://savannah.nongnu.org/download/streamtuner/${P}.tar.gz"
HOMEPAGE="http://www.nongnu.org/streamtuner/"

IUSE=""
SLOT="0"
KEYWORDS="amd64 ~ppc sparc x86"
LICENSE="BSD"

DEPEND=">=net-misc/streamtuner-0.12.0"

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog NEWS README
}
