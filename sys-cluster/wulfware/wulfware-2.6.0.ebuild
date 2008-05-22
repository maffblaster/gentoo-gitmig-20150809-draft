# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/wulfware/wulfware-2.6.0.ebuild,v 1.1 2008/05/22 14:40:51 drac Exp $

inherit autotools eutils multilib toolchain-funcs

DESCRIPTION="Applications to monitor on a beowulf- or GRID-style clusters."
HOMEPAGE="http://www.phy.duke.edu/~rgb/Beowulf/wulfware.php"
SRC_URI="http://www.phy.duke.edu/~rgb/Beowulf/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/libxml2
	sys-libs/ncurses
	sys-libs/zlib"
DEPEND="${RDEPEND}
	!sys-cluster/wulfstat
	!sys-cluster/xmlsysd"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-opts_and_strip.patch
	eautoreconf
}

src_compile() {
	econf --disable-dependency-tracking
	emake -j1 CC=$(tc-getCC) || die "emake failed."
}

src_install() {
	emake prefix="${D}/usr" libdir="${D}/usr/$(get_libdir)" \
		includedir="${D}/usr/include" sysconfdir="${D}/etc" \
		install || die "emake install failed."

	dodoc AUTHORS ChangeLog NEWS NOTES README

	# FIXME: Update to Gentoo style init script.
	rm -rf "${D}"/etc/init.d/wulf2html
}

pkg_postinst() {
	elog "If you havent done so already please execute the following command"
	elog "\"emerge --config =${CATEGORY}/${PF}\""
	elog "to add xmlsysd to /etc/services."
	elog
	elog "Be sure to edit /etc/xinetd.d/xmylsysd to suit your own options."
}

pkg_config() {
	echo "xmlsysd		7887/tcp	# xmlsysd remote system stats" >> /etc/services
	einfo "Added xmlsysd to /etc/services"
}
