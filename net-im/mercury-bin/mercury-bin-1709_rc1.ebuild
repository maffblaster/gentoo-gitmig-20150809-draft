# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/mercury-bin/mercury-bin-1709_rc1.ebuild,v 1.1 2005/03/17 18:41:20 axxo Exp $

inherit eutils java-pkg

MY_PV="1709_B7"
DESCRIPTION="MSN and Jabber client in Java"

HOMEPAGE="http://www.mercury.to/"
##Mercury.to dos not provided http or ftp links so i did a mirror
SRC_URI="http://www.keanu.be/1709_RC1.zip"
LICENSE="mercury"
SLOT="0"
KEYWORDS="~x86"
DEPEND="app-arch/unzip
		>=virtual/jdk-1.4"

RDEPEND=">=virtual/jre-1.4
		=dev-java/jgoodies-looks-1.3*
		dev-java/jmf-bin
		dev-java/jdictrayapi
		dev-java/xpp3
		~dev-java/jdom-1.0"
IUSE=""

S=${WORKDIR}
src_unpack() {
	unpack ${A}
	cd ${S}
	rm -f *.dll *.so

	#Clean the dllStuff.jar from things we dont need
	cd lib
	mkdir dllStuff
	cd dllStuff
	unzip ../dllStuff.jar
	rm -rf ../dllStuff.jar org/jdesktop x10gimli/platform

	cd ${S}
	rm lib/XML.jar # jdom
	rm lib/looks-*.jar #jgoodies-looks
	rm lib/JFlash.jar # seems to be trial from http://www.javaapis.com/jflashplayer/ which says its windows only
	rm lib/xmlpull.jar # xpp3
}

src_install() {
	#rebuild the dllStuff.jar
	cd ${S}/lib/dllStuff
	jar cf ../dllStuff.jar *
	cd ${S}
	rm -rf lib/dllStuff

	#Start installing stuff
	insinto /opt/${PN}/resources
	doins -r resources/*
	java-pkg_dojar lib/*

	insinto /usr/share/pixmaps
	newins  ${FILESDIR}/icon32.gif mercury.gif

	exeinto /opt/bin
	newexe ${FILESDIR}/mercury.sh mercury

	make_desktop_entry mercury "Mercury MSN client" /usr/share/pixmaps/mercury.gif
}
