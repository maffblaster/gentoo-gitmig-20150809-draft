# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/qdox/qdox-1.12.ebuild,v 1.4 2012/01/28 15:13:54 phajdan.jr Exp $

EAPI="3"
JAVA_PKG_IUSE="doc source"
inherit java-pkg-2 java-ant-2
DESCRIPTION="Parser for extracting class/interface/method definitions"
HOMEPAGE="http://qdox.codehaus.org/"
SRC_URI="http://snapshots.repository.codehaus.org/com/thoughtworks/qdox/qdox/1.12-SNAPSHOT/qdox-1.12-20100531.205010-5-project.tar.gz  "
LICENSE="Apache-2.0"
SLOT="1.12"
KEYWORDS="amd64 x86"
IUSE=""
S="${WORKDIR}/${PN}-${PV}-SNAPSHOT"

CDEPEND="dev-java/ant-core
	dev-java/junit"
DEPEND=">=virtual/jdk-1.4
	app-arch/unzip
	dev-java/byaccj
	>=dev-java/jflex-1.4.3
	dev-java/jmock
	${CDEPEND}"
RDEPEND=">=virtual/jre-1.4
	${CDEPEND}"

src_compile() {
	jflex src/grammar/lexer.flex --skel src/grammar/skeleton.inner -d src/java/com/thoughtworks/qdox/parser/impl/
	byaccj -v -Jnorun -Jnoconstruct -Jclass=Parser -Jsemantic=Value -Jpackage=com.thoughtworks.qdox.parser.impl src/grammar/parser.y
	mv Parser.java src/java/com/thoughtworks/qdox/parser/impl/
	# create jar
	mkdir -p build/classes
	ejavac -sourcepath . -d build/classes -classpath $(java-pkg_getjars --build-only ant-core,junit,jmock-1.0) \
		$(find . -name "*.java") || die "Cannot compile sources"
	mkdir dist
	cd build/classes
	jar -cvf "${S}/dist/${PN}.jar" com || die "Cannot create JAR"

	# generate javadoc
	if use doc ; then
		cd "${S}"
		mkdir javadoc
		javadoc -d javadoc -sourcepath src/java -subpackages com -classpath $(java-pkg_getjars ant-core,junit)
	fi
}

src_install() {
	java-pkg_dojar dist/${PN}.jar
	java-pkg_register-ant-task

	use source && java-pkg_dosrc src/java/com
	use doc && java-pkg_dojavadoc javadoc
}
