# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/portpeek/portpeek-2.0.7.ebuild,v 1.1 2010/09/13 15:08:52 mpagano Exp $

EAPI="2"
PYTHON_DEPEND="3"

inherit eutils python git

DESCRIPTION="A helper program for maintaining the package.keyword and package.unmask files"
HOMEPAGE="http://www.mpagano.com/blog/?page_id=3"
SRC_URI=""

EGIT_REPO_URI="git://mpagano.com/var/git/portpeek.git"
EGIT_COMMIT="v${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=">=app-portage/gentoolkit-0.3.0_rc10-r1
	>=sys-apps/portage-2.2_rc81"

pkg_setup() {
	python_set_active_version 3
}

src_prepare() {
	python_convert_shebangs 3 portpeek
}

src_install() {
	dobin ${PN} || die "dobin failed"
	doman *.[0-9]
}
