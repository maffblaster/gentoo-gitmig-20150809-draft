# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xmldiff/xmldiff-0.6.9.ebuild,v 1.7 2010/07/31 12:54:08 pacho Exp $

inherit eutils distutils

DESCRIPTION="a tool that figures out the differences between two similar
XML files"
HOMEPAGE="http://www.logilab.org/projects/xmldiff/"
SRC_URI="ftp://ftp.logilab.fr/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~ia64 ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-python/pyxml"

DOCS="ChangeLog README README.xmlrev TODO"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e "/^__revision__/d" setup.py test/regrtest.py || die "sed failed"
}
