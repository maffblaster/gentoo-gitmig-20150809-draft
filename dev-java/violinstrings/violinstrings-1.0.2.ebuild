# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/violinstrings/violinstrings-1.0.2.ebuild,v 1.3 2004/06/24 22:45:02 agriffis Exp $

inherit java-pkg

DESCRIPTION="ViolinStrings is a very useful Java package written by Michael Schmelling that provides dozens of functions to manipulate strings."
SRC_URI="http://vigna.dsi.unimi.it/ViolinStrings/${P}-src.tar.gz"
HOMEPAGE="http://vigna.dsi.unimi.it/ViolinStrings/"
LICENSE="X11"
SLOT="0"
KEYWORDS="x86"
RDEPEND=">=virtual/jdk-1.4"
DEPEND=">=virtual/jre-1.4"

src_compile() {
	local antflags="jar"
	use jikes && antflags="${antflags} -Dbuild.compiler=jikes"
	use doc && antflags="${antflags} javadoc"
	ant ${antflags} || die "compilation error"
}

src_install() {
	java-pkg_dojar *.jar
	dodoc CHANGES
	use doc && dohtml -r docs/*
}

