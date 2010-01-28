# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/freehep-stdhep/freehep-stdhep-2.0.2.ebuild,v 1.1 2010/01/28 17:51:46 weaver Exp $

JAVA_PKG_IUSE=""
GROUP_ID="org.freehep"
MAVEN2_REPOSITORIES="http://java.freehep.org/maven2"

inherit java-pkg-2 java-mvn-src

DESCRIPTION="High Energy Physics Java library - FreeHEP STDHep IO Library"
HOMEPAGE="http://java.freehep.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

CDEPEND=">=dev-java/freehep-mcfio-2.0.1
	>=dev-java/junit-3.8.2
	dev-java/freehep-xdr"
DEPEND=">=virtual/jdk-1.5
	${CDEPEND}"
RDEPEND=">=virtual/jre-1.5
	${CDEPEND}"
JAVA_GENTOO_CLASSPATH="freehep-mcfio,junit,freehep-xdr"
