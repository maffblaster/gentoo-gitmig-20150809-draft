# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-adobe-utopia-100dpi/font-adobe-utopia-100dpi-0.99.1.ebuild,v 1.2 2005/11/17 12:25:38 herbs Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular


DESCRIPTION="BigReqs prototype headers"
KEYWORDS="~amd64 ~arm ~ia64 ~s390 ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/mkfontdir
	x11-apps/mkfontscale
	x11-apps/bdftopcf
	media-fonts/font-util"

CONFIGURE_OPTIONS="--with-mapfiles=${XDIR}/share/fonts/util"

src_unpack() {
	x-modular_unpack_source
	x-modular_patch_source

	sed -i -e "s:^fontdir =.*:fontdir = \$(datadir)/fonts/\$(FONT_DIR):g" \
		${S}/Makefile.am

	x-modular_reconf_source
}
