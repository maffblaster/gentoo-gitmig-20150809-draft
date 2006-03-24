# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgtop/libgtop-1.0.13-r2.ebuild,v 1.24 2006/03/24 17:24:38 agriffis Exp $

inherit eutils

IUSE="nls"
DESCRIPTION="libgtop"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/sources/${PN}/1.0/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"
SLOT="1"
LICENSE="LGPL-2.1"
KEYWORDS="~amd64 hppa ia64 ppc sparc x86"

RDEPEND=">=sys-devel/bc-1.06
	>=sys-libs/readline-4.1
	>=gnome-base/gnome-libs-1.4.1.2-r1"

DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	>=dev-util/guile-1.4
	dev-lang/perl"


src_unpack() {
	unpack ${A}

	# Fix a remote buffer overflow vuln.
	cd ${S}
	epatch ${FILESDIR}/${PV}-remote_buffer_overflow.diff
	# guile compile fix
	epatch ${FILESDIR}/${PN}-${PV}-guile-compile.patch
	automake-1.4
}

src_compile() {

	local myconf

	if ! use nls
	then
		myconf="--disable-nls"
	fi

	./configure --host=${CHOST} 					\
		    --prefix=/usr					\
	            --sysconfdir=/etc					\
		    --localstatedir=/var/lib				\
		    --infodir=/usr/share/info				\
		    ${myconf} || die

	emake || die
}

src_install() {

	cd ${S}/doc
	# Add a INFO-DIR-SECTION section to the info file
	patch <${FILESDIR}/libgtop.info.diff || die
	cd ${S}

	make prefix=${D}/usr						\
		sysconfdir=${D}/etc					\
		localstatedir=${D}/var/lib					\
		infodir=${D}/usr/share/info				\
		install || die

	dodoc ABOUT-NLS AUTHORS COPYING* ChangeLog INSTALL LIBGTOP*
	dodoc NEWS RELNOTES* README
}
