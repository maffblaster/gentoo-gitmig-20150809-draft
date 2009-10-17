# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksysguard/ksysguard-4.3.2.ebuild,v 1.2 2009/10/17 08:58:16 abcd Exp $

EAPI="2"

KMNAME="kdebase-workspace"
CPPUNIT_REQUIRED="optional"
inherit kde4-meta

DESCRIPTION="KSysguard is a network enabled task manager and system monitor application."
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug +handbook lm_sensors"

# tests fail, last checked for 4.3.1
RESTRICT="test"

COMMONDEPEND="
	x11-libs/libXrender
	x11-libs/libXres
	lm_sensors? ( sys-apps/lm_sensors )
"
DEPEND="${COMMONDEPEND}
	x11-proto/renderproto
"
RDEPEND="${COMMONDEPEND}"

KMEXTRA="
	libs/ksysguard/
"

src_configure() {
	mycmakeargs="${mycmakeargs}
		$(cmake-utils_use_with lm_sensors Sensors)"

	kde4-meta_src_configure
}
