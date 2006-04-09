# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/evolution-sharp/evolution-sharp-0.10.2-r2.ebuild,v 1.1 2006/04/09 15:24:49 cretin Exp $

inherit mono versionator eutils autotools
DESCRIPTION="Mono bindings for Evolution"
HOMEPAGE="http://www.gnome.org/projects/beagle/"
SRC_URI="mirror://gnome/sources/${PN}/$(get_version_component_range 1-2)/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

DEPEND=">=gnome-extra/evolution-data-server-1.2
	>=dev-lang/mono-1.0
	>=dev-dotnet/gtk-sharp-2.3.90
	>=mail-client/evolution-2.2.0"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Use correct libdir in pkgconfig files
	sed -i -e 's:^libdir.*:libdir=@libdir@:' \
		${S}/*.pc.in || die

	# Bug 124581, fixed upstream
	epatch ${FILESDIR}/${P}-use-glibsharpglue-2.patch

	epatch ${FILESDIR}/${P}-check-evo-2.6.patch
	eautoconf
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog MAINTAINERS NEWS README
}

