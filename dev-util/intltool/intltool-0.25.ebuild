# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/intltool/intltool-0.25.ebuild,v 1.2 2003/02/09 15:16:50 foser Exp $

inherit gnome.org

S=${WORKDIR}/${P}
DESCRIPTION="Scripts for extracting translatable strings from various sourcefiles"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

DEPEND=">=dev-libs/popt-1.5
	>=sys-devel/perl-5.6.0"

src_compile() {                           
	econf || die "configure flawed" 
	emake || die "compile flawed" 
}

src_install() {
	einstall || die "installation failed"
	dodoc AUTHORS ChangeLog NEWS README TODO COPYING INSTALL
	dodoc doc/I18N-HOWTO
}
