# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-apps/kdeutils-meta/kdeutils-meta-4.14.3.ebuild,v 1.1 2015/06/04 18:44:38 kensington Exp $

EAPI=5
inherit kde4-meta-pkg

DESCRIPTION="kdeutils - merge this to pull in all kdeutils-derived packages"
HOMEPAGE="http://www.kde.org/applications/utilities http://utils.kde.org"
KEYWORDS="amd64 ~arm ppc ppc64 x86 ~amd64-linux ~x86-linux"
IUSE="cups floppy lirc"

RDEPEND="
	$(add_kdeapps_dep ark)
	$(add_kdeapps_dep filelight)
	$(add_kdeapps_dep kcalc)
	$(add_kdeapps_dep kcharselect)
	$(add_kdeapps_dep kdf)
	$(add_kdeapps_dep kgpg)
	$(add_kdeapps_dep ktimer)
	$(add_kdeapps_dep kwalletmanager)
	$(add_kdeapps_dep superkaramba)
	$(add_kdeapps_dep sweeper)
	cups? ( $(add_kdeapps_dep print-manager) )
	floppy? ( $(add_kdeapps_dep kfloppy) )
	lirc? ( $(add_kdeapps_dep kremotecontrol) )
"
