# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/esound/esound-0.2.32-r1.ebuild,v 1.2 2004/02/04 05:46:01 augustus Exp $

inherit libtool gnome.org eutils

DESCRIPTION="The Enlightened Sound Daemon"
HOMEPAGE="http://www.tux.org/~ricdude/EsounD.html"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"
IUSE="tcpd alsa ipv6"

DEPEND=">=media-libs/audiofile-0.1.5
	alsa? ( >=media-libs/alsa-lib-0.5.10b )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-new-alsa.patch
	use amd64 && epatch ${FILESDIR}/${P}-amd64.patch
	autoconf || die "autoconf failed"
	autoheader || die "autoheader failed"
}

src_compile() {
	elibtoolize

	econf \
		`use_with tcpd libwrap` \
		`use_enable alsa` \
		`use_enable ipv6` \
		--sysconfdir=/etc/esd \
		${myconf} || die

	make || die
}

src_install() {
	einstall \
		sysconfdir=${D}/etc/esd \
		|| die

	dodoc AUTHORS COPYING* ChangeLog README TODO NEWS TIPS
	dodoc docs/esound.ps

	dohtml -r docs/html

	insinto /etc/conf.d
	newins ${FILESDIR}/esound.conf.d esound

	exeinto /etc/init.d
	extradepend=""
	use tcpd && extradepend=" portmap"
	use alsa && extradepend="$extradepend alsasound"
	sed "s/@extradepend@/$extradepend/" <${FILESDIR}/esound.init.d >${T}/esound
	doexe ${T}/esound
}
