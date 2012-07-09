# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/atool/atool-0.39.0.ebuild,v 1.3 2012/07/09 11:51:58 ago Exp $

EAPI="4"

DESCRIPTION="a script for managing file archives of various types"
HOMEPAGE="http://www.nongnu.org/atool/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	!app-text/adiff"
