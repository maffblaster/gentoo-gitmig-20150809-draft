# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/psad/psad-1.2.4-r1.ebuild,v 1.2 2003/12/01 19:28:32 seemant Exp $

inherit eutils
inherit perl-module

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="Port Scannning Attack Detection daemon"
SRC_URI="http://www.cipherdyne.org/psad/download/psad-${PV}.tar.bz2"
HOMEPAGE="http://www.cipherdyne.org/psad"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~amd64 ~ia64 ~ppc ~alpha ~sparc ~hppa ~mips ~arm"

DEPEND="${DEPEND}
	dev-lang/perl"

RDEPEND="virtual/logger
	dev-perl/Unix-Syslog
	dev-perl/Date-Calc
	net-mail/mailx
	net-firewall/iptables"

src_compile() {
	cd ${S}/Psad
	SRC_PREP="no" perl-module_src_compile
	emake test

	cd ${S}/Net-IPv4Addr
	SRC_PREP="no" perl-module_src_compile
	emake test

	cd ${S}/IPTables/Parse
	SRC_PREP="no" perl-module_src_compile
	emake test

	cd ${S}/whois
	emake || die

	cd ${S}
	# Unofficial metalog patch
	epatch ${FILESDIR}/psad-${PV}-metalog.patch
	# We'll use the C binaries
	emake || die
}

src_install() {
	local myhostname=
	local mydomain=

	keepdir /var/lib/psad /var/log/psad /var/run/psad /var/lock/subsys/${PN}
	dodir /etc/psad
	cd ${S}/Psad
	insinto /usr/lib/psad
	doins Psad.pm

	cd ${S}/Net-IPv4Addr
	insinto /usr/lib/psad/Net
	doins IPv4Addr.pm

	cd ${S}/IPTables/Parse
	insinto /usr/lib/psad/IPTables
	doins Parse.pm

	cd ${S}/whois
	# Makefile seems borken, do install by hand...
	insinto /usr
	newbin whois whois_psad
	newman whois.1 whois_psad.1

	cd ${S}
	insinto /usr
	dosbin kmsgsd psad psadwatchd
	dobin pscan

	cd ${S}

	# Ditch the _CHANGEME_ for hostname, substituting in our real hostname
	myhostname="$(< /etc/hostname)"
	[ -e /etc/dnsdomainname ] && mydomain=".$(< /etc/dnsdomainname)"
	cp psad.conf psad.conf.orig
	sed -i "s:HOSTNAME\(.\+\)\_CHANGEME\_;:HOSTNAME\1${myhostname}${mydomain};:" psad.conf || die "Sed failed."

	insinto /etc/psad
	doins *.conf
	doins psad_*

	insinto /etc/init.d
	newins psad-init.gentoo psad

	cd ${S}/snort_rules
	dodir /etc/psad/snort_rules
	insinto /etc/psad/snort_rules
	doins *.rules

	cd ${S}
	dodoc BENCHMARK CREDITS Change* FW_EXAMPLE_RULES README LICENSE SCAN_LOG
}

pkg_postinst() {
	if [ ! -p ${ROOT}/var/lib/psad/psadfifo ]
	then
		ebegin "Creating syslog FIFO for PSAD"
		mknod -m 600 ${ROOT}/var/lib/psad/psadfifo p
		eend $?
	fi

	echo
	einfo "Please be sure to edit /etc/psad/psad.conf to reflect your system's"
	einfo "configuration or it may not work correctly or start up. Specifically, check"
	einfo "the validity of the HOSTNAME setting and replace the EMAIL_ADDRESSES setting"
	einfo "at the least."
	echo
	ewarn "Metalog support was added in psad-1.2.4-r1. Please note that metalog"
	ewarn "support is experimental and has not yet been added officially to psad."
}
