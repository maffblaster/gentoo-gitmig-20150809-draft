# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/haskell-src/haskell-src-1.0.1.3.ebuild,v 1.3 2010/11/06 12:33:35 hwoarang Exp $

CABAL_FEATURES="lib profile haddock happy"
inherit haskell-cabal

DESCRIPTION="Manipulating Haskell source code"
HOMEPAGE="http://haskell.org/ghc/"
SRC_URI="http://hackage.haskell.org/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/ghc-6.6.1
		>=dev-haskell/cabal-1.2"
