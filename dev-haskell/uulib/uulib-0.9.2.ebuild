# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/uulib/uulib-0.9.2.ebuild,v 1.8 2006/10/11 23:45:53 dcoutts Exp $

CABAL_FEATURES="haddock lib"
inherit base haskell-cabal

DESCRIPTION="The Utrecht University parsing, printing and DData libraries"
HOMEPAGE="http://www.cs.uu.nl/wiki/HUT/AttributeGrammarSystem"
SRC_URI="http://abaris.zoo.cs.uu.nl:8080/wiki/pub/HUT/Download/${P}-src.tar.gz"
LICENSE="LGPL-2.1-UUST"
SLOT="0"

KEYWORDS="amd64 ~ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=virtual/ghc-6.2.2"

src_unpack() {
	base_src_unpack

	# GHC 6.6 is stricter in some class instance stuff
	sed -i 's/Extensions:/Extensions: UndecidableInstances/' "${S}/uulib.cabal"
}
