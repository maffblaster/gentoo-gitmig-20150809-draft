# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeaddons-docs-kicker-applets/kdeaddons-docs-kicker-applets-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:14 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="doc/kicker-applets"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="Documentation for the kicker applets from kdeaddons"
KEYWORDS="~x86"
IUSE=""
DEPEND=""

