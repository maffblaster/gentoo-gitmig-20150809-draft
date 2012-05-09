# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langczechslovak/texlive-langczechslovak-2011.ebuild,v 1.10 2012/05/09 15:06:03 aballier Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="cs csbulletin cslatex csplain hyphen-czech hyphen-slovak collection-langczechslovak
"
TEXLIVE_MODULE_DOC_CONTENTS="csbulletin.doc cslatex.doc "
TEXLIVE_MODULE_SRC_CONTENTS="cslatex.source "
inherit  texlive-module
DESCRIPTION="TeXLive Czech/Slovak"

LICENSE="GPL-2 as-is GPL-1 LPPL-1.3 "
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2011
>=dev-texlive/texlive-latex-2011
"
RDEPEND="${DEPEND} "
