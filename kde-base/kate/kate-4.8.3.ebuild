# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kate/kate-4.8.3.ebuild,v 1.1 2012/05/03 20:07:59 johu Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kate"
KDE_SCM="git"
inherit kde4-meta

DESCRIPTION="Kate is an MDI texteditor."
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug +plasma"

DEPEND="
	dev-libs/libxml2
	dev-libs/libxslt
"
RDEPEND="${DEPEND}
	$(add_kdebase_dep katepart)
"

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_with plasma)
	)

	kde4-meta_src_configure
}

pkg_postinst() {
	kde4-meta_pkg_postinst

	if ! has_version kde-base/kaddressbook:${SLOT}; then
		echo
		elog "File templates plugin requires kde-base/kaddressbook:${SLOT}."
		elog "Please install it if you plan to use this plugin."
		echo
	fi
}
