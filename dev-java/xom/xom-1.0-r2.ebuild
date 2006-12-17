# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/xom/xom-1.0-r2.ebuild,v 1.7 2006/12/17 15:58:03 dertobi123 Exp $

inherit java-pkg-2 java-ant-2

XOMVER="xom-${PV/_beta/b}"
DESCRIPTION="XOM is a new XML object model. It is a tree-based API for processing XML with Java that strives for correctness and simplicity."
HOMEPAGE="http://cafeconleche.org/XOM/index.html"
SRC_URI="http://cafeconleche.org/XOM/${XOMVER}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86 ~x86-fbsd"
IUSE="doc source"

RDEPEND=">=virtual/jre-1.3
	>=dev-java/xerces-2.7
	dev-java/xalan
	dev-java/junit
	dev-java/icu4j
	dev-java/tagsoup
	=dev-java/servletapi-2.4*"
DEPEND=">=virtual/jdk-1.3
	dev-java/ant-core
	source? ( app-arch/zip )
	${RDEPEND}"

S=${WORKDIR}/XOM

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f *.jar
	cd ${S}/lib
	rm -f *.jar
	java-pkg_jar-from junit
	java-pkg_jar-from xalan
	java-pkg_jar-from xerces-2
	java-pkg_jar-from servletapi-2.4
	java-pkg_jar-from icu4j icu4j.jar normalizer.jar
	java-pkg_jar-from tagsoup
}

src_compile() {
	local antflags="jar -Ddebug=off -Dtagsoup.jar=lib/tagsoup.jar"
	eant ${antflags} || die "Failed Compiling"
}

src_install() {
	java-pkg_newjar build/${XOMVER}.jar ${PN}.jar
	dodoc Todo.txt

	use doc && java-pkg_dohtml -r apidocs/
	use source && java-pkg_dosrc src/*
}
