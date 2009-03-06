# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-documentation-dutch/texlive-documentation-dutch-2008.ebuild,v 1.4 2009/03/06 20:47:14 jer Exp $

TEXLIVE_MODULE_CONTENTS="lkort lshort-dutch ntg collection-documentation-dutch
"
TEXLIVE_MODULE_DOC_CONTENTS="lkort.doc lshort-dutch.doc ntg.doc "
TEXLIVE_MODULE_SRC_CONTENTS=""
inherit texlive-module
DESCRIPTION="TeXLive Dutch documentation"

LICENSE="GPL-2 as-is freedist GPL-1 "
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ia64 ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND=">=dev-texlive/texlive-documentation-base-2008
"
RDEPEND="${DEPEND}"
