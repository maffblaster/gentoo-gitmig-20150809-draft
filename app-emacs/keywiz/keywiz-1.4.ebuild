# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/keywiz/keywiz-1.4.ebuild,v 1.4 2005/07/01 19:49:37 mkennedy Exp $

inherit elisp eutils

DESCRIPTION="Emacs key sequence quiz"
HOMEPAGE="http://www.ifa.au.dk/~harder/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="virtual/emacs"

SITEFILE=50keywiz-gentoo.el
