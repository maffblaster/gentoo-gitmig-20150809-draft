# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktalkd/ktalkd-3.5_beta1.ebuild,v 1.1 2005/09/22 20:44:02 flameeyes Exp $

KMNAME=kdenetwork
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="KDE talk daemon"
KEYWORDS="~amd64"
IUSE=""
KMEXTRA="doc/kcontrol/kcmktalkd"