# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/fusion-icon/fusion-icon-0.1-r1.ebuild,v 1.4 2011/04/18 21:58:54 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"

inherit distutils gnome2-utils

MINIMUM_COMPIZ_RELEASE=0.6.0

DESCRIPTION="Compiz Fusion Tray Icon and Manager"
HOMEPAGE="http://compiz-fusion.org"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk qt4"

RDEPEND="
	>=dev-python/compizconfig-python-${MINIMUM_COMPIZ_RELEASE}
	>=x11-wm/compiz-${MINIMUM_COMPIZ_RELEASE}
	x11-apps/xvinfo
	gtk? ( >=dev-python/pygtk-2.10:2 )
	qt4? ( dev-python/PyQt4[X] )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

PYTHON_MODNAME="FusionIcon"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	distutils_src_install

	use gtk || rm -fr "${ED}$(python_get_sitedir)/FusionIcon/interface_gtk"
	use qt4 || rm -fr "${ED}$(python_get_sitedir)/FusionIcon/interface_qt4"
}

pkg_postinst() {
	distutils_pkg_postinst

	use gtk && gnome2_icon_cache_update
}

pkg_postrm() {
	distutils_pkg_postrm

	use gtk && gnome2_icon_cache_update
}
