# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/gx-mail-notify/gx-mail-notify-0.4.4.ebuild,v 1.1 2010/10/06 20:45:44 tampakrap Exp $

EAPI=3

OPENGL_REQUIRED=always
inherit kde4-base

MY_P=gx_mail_notify-${PV}

DESCRIPTION="A plasmoid for checking unread mail"
HOMEPAGE="http://www.kde-look.org/content/show.php/GX+Mail+Notify?content=99617"
SRC_URI="http://www.kde-look.org/CONTENT/content-files/99617-${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="$(add_kdebase_dep plasma-workspace)"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${PN}-qt-4.7.patch" )

S=${WORKDIR}/${MY_P}

DOCS=( README )
