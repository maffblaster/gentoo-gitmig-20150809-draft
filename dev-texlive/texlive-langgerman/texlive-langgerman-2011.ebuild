# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-texlive/texlive-langgerman/texlive-langgerman-2011.ebuild,v 1.6 2012/03/02 19:55:30 ranger Exp $

EAPI="3"

TEXLIVE_MODULE_CONTENTS="bibleref-german dehyph-exptl booktabs-de csquotes-de etoolbox-de geometry-de german germbib germkorr kalender microtype-de r_und_s tipa-de umlaute hyphen-german collection-langgerman
"
TEXLIVE_MODULE_DOC_CONTENTS="bibleref-german.doc dehyph-exptl.doc booktabs-de.doc csquotes-de.doc etoolbox-de.doc geometry-de.doc german.doc germbib.doc germkorr.doc microtype-de.doc r_und_s.doc tipa-de.doc umlaute.doc "
TEXLIVE_MODULE_SRC_CONTENTS="german.source umlaute.source "
inherit  texlive-module
DESCRIPTION="TeXLive German"

LICENSE="GPL-2 as-is GPL-1 LPPL-1.3 "
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~mips ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE=""
DEPEND=">=dev-texlive/texlive-basic-2011
!<dev-texlive/texlive-latexextra-2009
"
RDEPEND="${DEPEND} "
