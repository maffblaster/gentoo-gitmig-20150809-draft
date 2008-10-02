# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/parley/parley-4.1.2.ebuild,v 1.1 2008/10/02 11:09:53 jmbsvicetto Exp $

EAPI="2"

KMNAME=kdeedu
inherit kde4-meta

DESCRIPTION="KDE Educational: vocabulary trainer"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook +plasma"

COMMONDEPEND=">=kde-base/libkdeedu-${PV}:${SLOT}
	dev-libs/libxslt
	dev-libs/libxml2
	plasma? ( kde-base/libplasma:${SLOT} )"
DEPEND="${COMMONDEPEND}"
RDEPEND="${COMMONDEPEND}"

KMEXTRACTONLY="libkdeedu/keduvocdocument"

src_configure() {
	mycmakeargs="${mycmakeargs}
		-DWITH_LibXml2=On -DWITH_LibXslt=On
		$(cmake-utils_use_with plasma Plasma)"

	kde4-meta_src_configure
}
