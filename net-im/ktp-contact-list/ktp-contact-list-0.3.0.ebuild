# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ktp-contact-list/ktp-contact-list-0.3.0.ebuild,v 1.1 2012/01/25 22:53:24 johu Exp $

EAPI=4

KDE_LINGUAS="cs da de es et fr ga hu it ja km lt nds nl pl pt pt_BR sv ug uk
zh_CN zh_TW"
KDE_SCM="git"
inherit kde4-base

DESCRIPTION="KDE Telepathy contact list"
HOMEPAGE="http://community.kde.org/Real-Time_Communication_and_Collaboration"
if [[ ${PV} != *9999* ]]; then
	SRC_URI="mirror://kde/unstable/kde-telepathy/${PV}/src/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="GPL-2"
SLOT="4"
IUSE="debug"

DEPEND="
	>=net-im/ktp-accounts-kcm-${PV}
	>=net-im/ktp-common-internals-${PV}
	>=net-libs/telepathy-qt-0.9.0
"
RDEPEND="${DEPEND}"
