# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/syslog-ng/syslog-ng-2.1.3.ebuild,v 1.1 2008/12/02 19:27:09 mr_bones_ Exp $

inherit fixheadtails eutils

MY_PV=${PV/_/}
DESCRIPTION="syslog replacement with advanced filtering features"
HOMEPAGE="http://www.balabit.com/products/syslog_ng/"
SRC_URI="http://www.balabit.com/downloads/files/syslog-ng/sources/2.1/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="hardened ipv6 selinux spoof-source sql static tcpd"

RDEPEND=">=dev-libs/eventlog-0.2
	spoof-source? ( net-libs/libnet )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	sql? ( >=dev-db/libdbi-0.8.3 )
	>=dev-libs/glib-2.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/flex"
PROVIDE="virtual/logger"

src_unpack() {
	unpack ${A}
	cd "${S}/doc/reference"
	tar xzf syslog-ng.html.tar.gz || die "tar failed"
	cd "${S}"
	ht_fix_file configure
}

src_compile() {
	econf \
		--sysconfdir=/etc/syslog-ng \
		--disable-dependency-tracking \
		$(use_enable ipv6) \
		$(use_enable sql) \
		$(use_enable static static-linking) \
		$(use_enable spoof-source) \
		$(use_enable tcpd tcp-wrapper) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS README \
		doc/examples/{syslog-ng.conf.sample,syslog-ng.conf.solaris} \
		contrib/syslog-ng.conf* \
		doc/reference/syslog-ng.txt \
		contrib/syslog2ng "${FILESDIR}/syslog-ng.conf."*
	dohtml doc/reference/syslog-ng.html/*

	# Install default configuration
	insinto /etc/syslog-ng
	if use hardened || use selinux ; then
		newins "${FILESDIR}/syslog-ng.conf.gentoo.hardened" syslog-ng.conf
	elif use userland_BSD ; then
		newins "${FILESDIR}/syslog-ng.conf.gentoo.fbsd" syslog-ng.conf
	else
		newins "${FILESDIR}/syslog-ng.conf.gentoo" syslog-ng.conf
	fi

	insinto /etc/logrotate.d
	# Install snippet for logrotate, which may or may not be installed
	if use hardened || use selinux ; then
		newins "${FILESDIR}/syslog-ng.logrotate.hardened" syslog-ng
	else
		newins "${FILESDIR}/syslog-ng.logrotate" syslog-ng
	fi

	newinitd "${FILESDIR}/syslog-ng.rc6-r1" syslog-ng
	newconfd "${FILESDIR}/syslog-ng.confd" syslog-ng
}

pkg_postinst() {
	echo
	elog "It is highly recommended that app-admin/logrotate be emerged to"
	elog "manage the log files.  ${PN} installs a file in /etc/logrotate.d"
	elog "for logrotate to use."
	echo
}
