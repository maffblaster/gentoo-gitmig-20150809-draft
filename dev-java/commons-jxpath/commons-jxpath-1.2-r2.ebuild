# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/commons-jxpath/commons-jxpath-1.2-r2.ebuild,v 1.5 2007/04/27 03:46:34 wltjr Exp $

JAVA_PKG_IUSE="doc source test"

inherit java-pkg-2 java-ant-2

DESCRIPTION="Applies XPath expressions to graphs of objects of all kinds."
HOMEPAGE="http://jakarta.apache.org/commons/jxpath/"
SRC_URI="mirror://apache/jakarta/commons/jxpath/source/${P}-src.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86 ~x86-fbsd"
IUSE=""

COMMON_DEPEND="=dev-java/commons-beanutils-1.6*
	=dev-java/servletapi-2.3*
	>=dev-java/jdom-1.0"
RDEPEND=">=virtual/jre-1.4
	${COMMON_DEPEND}"
# Java 1.6's javadoc doesn't like enums
DEPEND="|| ( =virtual/jdk-1.5* =virtual/jdk-1.4* )
	test? (
		dev-java/ant
		dev-java/commons-collections
		dev-java/commons-logging
		=dev-java/junit-3.8*
	)
	${COMMON_DEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Don't automatically run tests
	epatch "${FILESDIR}/${P}-gentoo.patch"

	mkdir -p ${S}/target/lib
	cd ${S}/target/lib
	java-pkg_jar-from commons-beanutils-1.6
	java-pkg_jar-from servletapi-2.3
	java-pkg_jar-from jdom-1.0
	if use test ; then
		java-pkg_jar-from --build-only commons-collections
		java-pkg_jar-from --build-only commons-logging
		java-pkg_jar-from --build-only junit
	fi
}

src_test() {
	eant test
}

src_install() {
	java-pkg_dojar target/${PN}.jar
	use doc && java-pkg_dojavadoc dist/docs/api
	use source && java-pkg_dosrc src/java/*
}
