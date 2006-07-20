# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-emnu/embassy-emnu-1.05-r2.ebuild,v 1.6 2006/07/20 20:46:03 ribosome Exp $

EBOV="3.0.0"

inherit embassy

DESCRIPTION="EMBOSS Menu is Not UNIX - Simple menu of EMBOSS applications"

RESTRICT="nomirror"

KEYWORDS="ppc ppc-macos x86"

RDEPEND="sys-libs/ncurses
	${RDEPEND}"

DEPEND="sys-libs/ncurses
	${DEPEND}"
