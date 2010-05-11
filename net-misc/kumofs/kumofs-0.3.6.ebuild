# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/kumofs/kumofs-0.3.6.ebuild,v 1.1 2010/05/11 14:47:48 matsuu Exp $

EAPI="2"

DESCRIPTION="a scalable and highly available distributed key-value store"
HOMEPAGE="http://github.com/etolabo/kumofs"
SRC_URI="http://cloud.github.com/downloads/etolabo/kumofs/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-db/tokyocabinet-1.4.10
	>=dev-libs/msgpack-0.3.1
	dev-libs/openssl
	>=dev-ruby/msgpack-0.3.1
	>=dev-lang/ruby-1.8.6
	sys-libs/zlib"
RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die

	newinitd "${FILESDIR}/kumo-gateway.initd" kumo-gateway || die
	newconfd "${FILESDIR}/kumo-gateway.confd" kumo-gateway || die
	newinitd "${FILESDIR}/kumo-manager.initd" kumo-manager || die
	newconfd "${FILESDIR}/kumo-manager.confd" kumo-manager || die
	newinitd "${FILESDIR}/kumo-server.initd" kumo-server || die
	newconfd "${FILESDIR}/kumo-server.confd" kumo-server || die

	keepdir /var/lib/kumofs || die

	dodoc AUTHORS ChangeLog NEWS NOTICE README README.md doc/doc.*.md || die
}
