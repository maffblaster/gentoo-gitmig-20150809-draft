# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jarjar/jarjar-0.6-r1.ebuild,v 1.5 2007/03/01 12:32:48 opfer Exp $

inherit eutils java-pkg-2 java-ant-2

DESCRIPTION="Tool for repackaging third-party jars."
SRC_URI="mirror://sourceforge/jarjar/${PN}-src-${PV}.zip"
HOMEPAGE="http://jarjar.sourceforge.net"
LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~amd64 x86"
IUSE="doc source"
COMMON_DEP="
	=dev-java/asm-2.0*
	=dev-java/gnu-regexp-1*"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEP}"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	>=dev-java/ant-core-1.4
	source? ( app-arch/zip )
	${COMMON_DEP}"

# FIXME looks like it bundles stuff from dev-java/java-getopt, ie
# gnu.getopt.*, so this should delete the bundled files, and then
# depend on java-getopt. Should also probably report upstream. -nichoj

src_unpack() {
	unpack ${A}

	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from asm-2
	java-pkg_jar-from gnu-regexp-1
	java-pkg_jar-from ant-core ant.jar
}

src_install() {
	java-pkg_newjar dist/${P}.jar ${PN}.jar

	use doc && java-pkg_dojavadoc dist/javadoc
	use source && java-pkg_dosrc src/main/*
}
