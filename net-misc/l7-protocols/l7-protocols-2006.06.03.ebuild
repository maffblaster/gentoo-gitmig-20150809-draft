# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/l7-protocols/l7-protocols-2006.06.03.ebuild,v 1.8 2007/02/05 19:02:27 wolf31o2 Exp $

inherit toolchain-funcs

IUSE=""

MY_P=${PN}-${PV//./-}

DESCRIPTION="Protocol definitions of l7-filter kernel modules"
HOMEPAGE="http://l7-filter.sourceforge.net/protocols"

SRC_URI="mirror://sourceforge/l7-filter/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ppc ppc64 sparc x86"
S=${WORKDIR}/${MY_P}


src_compile() {
	sed -i -e "s/gcc.*-O2/$(tc-getCC) ${CFLAGS}/g" testing/Makefile
	sed -i -e 's/-1/-n 1/g' testing/*.sh
	emake -C testing
}

# NOTE Testing mechanism is currently broken:
#  stack smashing attack in function main()
#src_test() {
#	cd testing
#	find ${S} -name \*.pat -print -exec ./test_match.sh {} \; \
#		-exec ./timeit.sh {} \; || die "failed tests"
#	einfo "patterns past testing"
#}

src_install() {

	dodir /usr/share/${PN}
	cd testing
	cp -pPR randprintable randchars test_speed match README *.sh ${D}/usr/share/${PN}
	cd ${S}

	dodoc README CHANGELOG HOWTO WANTED
	newdoc README.weakpatterns
	newdoc extra/README README.extra
	newdoc file_types/README README.file_types
	newdoc malware/README README.malware
	newdoc testing/README README.testing
	rm -rf README CHANGELOG HOWTO LICENSE WANTED */README testing

	make PREFIX=${D} install || die
	rm ${D}/etc/${PN}/Makefile
	chown -R root:0 ${D}
}
