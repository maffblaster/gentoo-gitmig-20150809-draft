# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/ebview/ebview-0.3.5.ebuild,v 1.5 2004/08/21 13:20:48 dholm Exp $

inherit eutils

IUSE=""

DESCRIPTION="EBView -- Electronic Book Viewer based on GTK+"
HOMEPAGE="http://ebview.sourceforge.net/"
SRC_URI="mirror://sourceforge/ebview/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.57"
RDEPEND=">=dev-libs/eb-3.3.4
	>=x11-libs/gtk+-2.2
	sys-devel/gettext"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-eb4-gentoo.diff
	epatch ${FILESDIR}/${PN}-gtk24.diff
	rm -rf autom4te.cache

	if has_version '>=sys-devel/gettext-0.12' ; then
		cd ${S}/po
		epatch ${FILESDIR}/${PN}-gettext-0.12-gentoo.diff
	fi
}

src_compile() {

	export WANT_AUTOCONF=2.5
	autoreconf || die

	econf --with-eb-conf=/etc/eb.conf || die
	emake || die
}

src_install () {

	einstall || die

	dodoc ABOUT-NLS AUTHORS ChangeLog INSTALL* NEWS README TODO
}
