# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/icecast/icecast-2.0.2.ebuild,v 1.2 2004/10/10 19:05:05 eradicator Exp $

IUSE="curl doc"

inherit eutils

DESCRIPTION="An opensource alternative to shoutcast that supports mp3 and ogg streaming"
HOMEPAGE="http://www.icecast.org/"
SRC_URI="http://svn.xiph.org/releases/icecast/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~ppc64"

DEPEND="dev-libs/libxslt
	media-libs/libogg
	media-libs/libvorbis
	curl? ( net-misc/curl )"

src_compile() {
	local myconf=""
	use curl || myconf="${myconf} --disable-yp"
	econf \
		--sysconfdir=/etc/icecast2 \
		${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README TODO HACKING NEWS conf/icecast.xml.dist
	use doc && dohtml -A chm,hhc,hhp doc/*

	exeinto /etc/init.d
	newexe ${FILESDIR}/init.d.icecast icecast

	rm -rf ${D}/usr/share/doc/icecast
}
