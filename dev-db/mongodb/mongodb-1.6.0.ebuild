# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/mongodb/mongodb-1.6.0.ebuild,v 1.3 2011/03/30 17:25:19 ultrabug Exp $

EAPI="2"

inherit eutils versionator

MY_PATCHVER=$(get_version_component_range 1-2)
MY_P="${PN}-src-r${PV}"

DESCRIPTION="A high-performance, open source, schema-free document-oriented database"
HOMEPAGE="http://www.mongodb.org"
SRC_URI="http://downloads.mongodb.org/src/${MY_P}.tar.gz"

LICENSE="AGPL-3 Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="v8"

RDEPEND="!v8? ( dev-lang/spidermonkey[unicode] )
	v8? ( dev-lang/v8 )
	dev-libs/boost
	dev-libs/libpcre"

DEPEND="${RDEPEND}
	>=dev-util/scons-1.2.0-r1
	sys-libs/readline
	sys-libs/ncurses"

# Must change this on every upgrade
S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup mongodb
	enewuser mongodb -1 -1 /var/lib/${PN} mongodb

	scons_opts="${MAKEOPTS}"
	if use v8; then
		scons_opts+=" --usev8"
	else
		scons_opts+=" --usesm"
	fi
}

src_prepare() {
	epatch "${FILESDIR}/${P}-fix-scons.patch"
#}	epatch "${FILESDIR}"/"${PN}"-"${MY_PATCHVER}"-modify-*.patch

	if use v8; then
		# Suppress known test failure with v8:
		# http://jira.mongodb.org/browse/SERVER-1147
		sed -e '/add< NumberLong >/d' -i dbtests/jstests.cpp || die
	fi
}

src_compile() {
	scons ${scons_opts} all || die "Compile failed"
}

src_install() {
	scons ${scons_opts} --full --nostrip install --prefix="${D}"/usr || die "Install failed"

	for x in /var/{lib,log,run}/${PN}; do
		dodir "${x}" || die "Install failed"
		fowners mongodb:mongodb "${x}"
	done

	doman debian/mongo*.1 || die "Install failed"
	dodoc README docs/building.md

	newinitd "${FILESDIR}/${PN}.initd" ${PN} || die "Install failed"
	newconfd "${FILESDIR}/${PN}.confd" ${PN} || die "Install failed"
}

src_test() {
	scons ${scons_opts} smoke --smokedbprefix='testdir' test || die "Tests failed"
}
