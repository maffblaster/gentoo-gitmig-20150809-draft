# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kontact/kontact-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:22 danarmak Exp $

KMNAME=kdepim
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE personal information manager"
KEYWORDS="~x86"
IUSE=""
OLDDEPEND="~kde-base/libkdepim-$PV"
DEPEND="
$(deprange $PV $MAXKDEVER kde-base/libkdepim)
$(deprange $PV $MAXKDEVER kde-base/libkpimidentities)"

KMCOPYLIB="libkdepim libkdepim/
	libkpimidentities.la libkpimidentities/"
KMEXTRACTONLY="libkdepim/
	libkpimidentities/
	kontact/plugins/"
KMEXTRA="
	kontact/plugins/newsticker/
	kontact/plugins/summary/
	kontact/plugins/weather/"
# We remove some plugins that are related to external kdepim's programs, because they needs also libs from korganizer, kpilot etc... so to emerge kontact we'll need also ALL the other programs, it's better to emerge the kontact's plugins in the ebuild of its program

