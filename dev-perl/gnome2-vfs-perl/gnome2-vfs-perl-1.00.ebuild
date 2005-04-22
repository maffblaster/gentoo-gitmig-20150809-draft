# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-vfs-perl/gnome2-vfs-perl-1.00.ebuild,v 1.5 2005/04/22 13:15:41 blubb Exp $

inherit perl-module

MY_P=Gnome2-VFS-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Perl interface to the 2.x series of the Gnome  VIrtual File System libraries."
HOMEPAGE="http://search.cpan.org/~rmcfarla/${P}/"
SRC_URI="http://search.cpan.org/CPAN/authors/id/R/RM/RMCFARLA/Gtk2-Perl/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc ~ppc ~alpha hppa amd64"
IUSE=""

DEPEND=">=dev-perl/extutils-depends-0.2*
	dev-perl/extutils-pkgconfig
	>=gnome-base/gnome-vfs-2
	>=dev-perl/glib-perl-1.04
	>=dev-perl/gtk2-perl-1.02"
