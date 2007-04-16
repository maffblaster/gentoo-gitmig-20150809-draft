# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/ebuild-mode/ebuild-mode-1.5-r1.ebuild,v 1.1 2007/04/16 18:50:42 opfer Exp $

inherit elisp

DESCRIPTION="An Emacs mode for editing Portage .ebuild, .eclass and .eselect files."
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

SITEFILE=50ebuild-mode-gentoo.el
