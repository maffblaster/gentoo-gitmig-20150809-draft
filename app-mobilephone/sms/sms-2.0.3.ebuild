# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-mobilephone/sms/sms-2.0.3.ebuild,v 1.3 2006/04/13 20:03:26 mrness Exp $

inherit toolchain-funcs

DESCRIPTION="Command line program for sending SMS to Polish GSM mobile phone users"
HOMEPAGE="http://ceti.pl/~miki/komputery/sms.html"
SRC_URI="http://ceti.pl/~miki/komputery/download/sms/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE=""

DEPEND="sys-libs/gdbm
	dev-libs/libpcre
	dev-libs/pcre++
	net-misc/curl"

src_compile() {
	emake CXX=$(tc-getCXX) CXXFLAGS="${CXXFLAGS} -I./lib" LDFLAGS="-lc" || die "make failed"
}

src_install() {
	dobin sms smsaddr
	dodoc README README.smsrc Changelog doc/readme.html
	dodoc contrib/mimecut contrib/procmailrc
}
