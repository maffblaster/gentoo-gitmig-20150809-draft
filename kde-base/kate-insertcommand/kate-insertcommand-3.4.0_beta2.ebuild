# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kate-insertcommand/kate-insertcommand-3.4.0_beta2.ebuild,v 1.1 2005/02/05 11:39:12 danarmak Exp $
KMNAME=kdeaddons
KMNOMODULE=true
KMEXTRA="kate/insertcommand"
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="kate plugin for inserting the output of an arbitrary command"
KEYWORDS="~x86"
IUSE=""
DEPEND="$(deprange $PV $MAXKDEVER kde-base/kate)
$(deprange $PV $MAXKDEVER kde-base/kdeaddons-docs-kate-plugins)"
OLDDEPEND="~kde-base/kate-$PV ~kde-base/kdeaddons-docs-kate-plugins-$PV"
