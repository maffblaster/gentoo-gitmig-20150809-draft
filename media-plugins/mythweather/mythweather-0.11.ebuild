# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/mythweather/mythweather-0.11.ebuild,v 1.1 2003/08/18 18:07:05 max Exp $

inherit flag-o-matic

DESCRIPTION="Weather forcast module for MythTV."
HOMEPAGE="http://www.mythtv.org/"
SRC_URI="http://www.mythtv.org/mc/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=sys-apps/sed-4
	|| ( >=media-tv/mythtv-${PV} >=media-tv/mythfrontend-${PV} )"

src_unpack() {
	unpack ${A}

	for i in `grep -lr "usr/local" "${S}"` ; do
		sed -e "s:/usr/local:/usr:" -i "${i}" || die "sed failed"
	done
}

src_compile() {
	cpu="`get-flag march`"
	if [ ! -z "${cpu}" ] ; then
		sed -e "s:pentiumpro:${cpu}:g" -i "${S}/settings.pro" || die "sed failed"
	fi

	qmake -o "${S}/Makefile" "${S}/${PN}.pro"

	emake || die "compile problem"
}

src_install() {
	einstall INSTALL_ROOT="${D}"
	dodoc AUTHORS COPYING README
}
