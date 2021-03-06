# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-haskell/ansi-wl-pprint/ansi-wl-pprint-0.6.7.1.ebuild,v 1.8 2015/08/04 11:40:34 zlogene Exp $

EAPI=5

# ebuild generated by hackport 0.3.5.9999

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="The Wadler/Leijen Pretty Printer for colored ANSI terminal output"
HOMEPAGE="http://github.com/batterseapower/ansi-wl-pprint"
SRC_URI="mirror://hackage/packages/archive/${PN}/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="example"

RDEPEND=">=dev-haskell/ansi-terminal-0.4.0:=[profile?] <dev-haskell/ansi-terminal-0.7:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.2
"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag example example)
}
