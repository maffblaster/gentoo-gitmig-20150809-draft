# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xarchiver/xarchiver-0.4.2_rc2.ebuild,v 1.4 2006/12/12 14:20:22 jer Exp $

inherit eutils xfce44 versionator

MY_PV="$(replace_version_separator 3 '')"
MY_P="${PN}-${MY_PV}"
S="${WORKDIR}/${MY_P}"

xfce44_beta
xfce44_extra_package

DESCRIPTION="Xarchiver is a GTK2 frontend to rar, zip, bzip2, tar, gzip
and rpm for Xfce"
HOMEPAGE="http://xarchiver.xfce.org/"

KEYWORDS="~amd64 ~hppa ~ppc ~x86"
IUSE="ace rar 7zip rpm"

DEPEND=">=x11-libs/gtk+-2.6
	app-arch/zip
	app-arch/bzip2
	ace? ( app-arch/unace )
	rar? ( app-arch/rar )
	7zip? ( app-arch/p7zip )
	rpm? ( app-arch/rpm )"
