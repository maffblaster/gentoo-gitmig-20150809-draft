# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-ru/aspell-ru-0.99.1.ebuild,v 1.19 2009/10/18 20:44:39 halcy0n Exp $

ASPELL_LANG="Russian"
ASPOSTFIX="6"

inherit aspell-dict

LICENSE="GPL-2"

KEYWORDS="alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

# very strange filename not supported by the gentoo naming scheme
FILENAME=aspell6-ru-0.99f7-1

SRC_URI="mirror://gnu/aspell/dict/ru/${FILENAME}.tar.bz2"
S="${WORKDIR}/${FILENAME}"
