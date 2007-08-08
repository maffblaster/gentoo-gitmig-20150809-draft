# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeadmin-kfile-plugins/kdeadmin-kfile-plugins-3.5.7.ebuild,v 1.5 2007/08/08 20:45:22 armin76 Exp $
KMNAME=kdeadmin
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta
KMMODULE=kfile-plugins

DESCRIPTION="kfile plugins from kdeadmin"
KEYWORDS="alpha ~amd64 ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility"
DEPEND=""
