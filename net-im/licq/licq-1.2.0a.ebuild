# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/licq/licq-1.2.0a.ebuild,v 1.1 2002/08/13 14:45:08 agenkin Exp $

DESCRIPTION="ICQ Client with v8 support" 
HOMEPAGE="http://www.licq.org"
LICENSE="GPL-2"

DEPEND="${DEPEND}
	ssl? ( >=dev-libs/openssl-0.9.6 )
	qt?  ( >=x11-libs/qt-3.0.0 )"

SRC_URI="http://download.sourceforge.net/licq/${P}.tar.bz2"
SLOT="2"
KEYWORDS="x86"
S=${WORKDIR}/${P}

use kde && inherit kde-base
use kde && need-kde 3.0

src_compile() {

	local first_conf
	use ssl		|| first_conf = "${first_conf} --disable-openssl"
	use socks5	&& first_conf = "${first_conf} --enable-socks5"
	
	./configure --host=${CHOST} --prefix=/usr ${first_conf} || die
	emake || die

	if [ "`use qt`" ] 
	then
		# A hack to build against the latest QT:
		local v
		for v in /usr/qt/[0-9]
		do
			[ -d "${v}" ] && export QTDIR="${v}"
		done
		use kde && kde_src_compile myconf
		use kde && second_conf="${second_conf} ${myconf} --with-kde"

		# note! watch the --prefix=/usr placement;
		# licq itself installs into /usr, but the
		# optional kde/qt interface (to which second_conf belogns)
		# installs its files in $KDE3DIR/{lib,share}/licq

		cd plugins/qt-gui-1.2.0
		./configure --host=${CHOST} ${second_conf} --prefix=/usr || die
		emake || die
	fi

}

src_install() {

	cd ${S}
	make DESTDIR=${D} install || die
	if [ "`use qt`" ] 
	then
		cd plugins/qt-gui-1.2.0
		make DESTDIR=${D} install || die	
	fi

}
