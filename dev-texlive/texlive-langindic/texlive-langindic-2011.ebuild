# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langindic/texlive-langindic-2011.ebuild,v 1.4 2012/01/17 18:56:17 phajdan.jr Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="bangtex bengali burmese devnag ebong hyphen-indic hyphen-sanskrit itrans malayalam polyglossia-kannada sanskrit velthuis wnri wnri-latex xetex-devanagari collection-langindic
"
TEXLIVE_MODULE_DOC_CONTENTS="bangtex.doc bengali.doc burmese.doc ebong.doc itrans.doc malayalam.doc sanskrit.doc velthuis.doc wnri.doc wnri-latex.doc xetex-devanagari.doc "
TEXLIVE_MODULE_SRC_CONTENTS="bengali.source burmese.source malayalam.source sanskrit.source wnri-latex.source "
inherit  texlive-module
DESCRIPTION="TeXLive Indic scripts"

LICENSE="GPL-2 as-is GPL-1 GPL-2 LPPL-1.3 public-domain "
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2011
"
RDEPEND="${DEPEND} "
TEXLIVE_MODULE_BINSCRIPTS="texmf-dist/scripts/ebong/ebong.py"
