# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Zach Forrest <zach@disinformation.ca>
# $Header: /var/cvsroot/gentoo-x86/dev-util/ebuilder/ebuilder-0.3.ebuild,v 1.1 2002/05/04 01:20:48 karltk Exp $

S="${WORKDIR}/${P}"
DESCRIPTION="Package Builder for Gentoo Linux"
SRC_URI="http://www.disinformation.ca/gentoo/${P}.tar.gz"
HOMEPAGE="http://www.disinformation.ca/gentoo"
DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	echo "Nothing to compile for ${P}."
}

src_install () {
	dodir /usr/share/ebuilder
	dodir /usr/share/ebuilder/templates

	insinto /usr/share/ebuilder/templates
	doins templates/beginner.ebuild
	doins templates/expert.ebuild

	dosbin ebuilder

	# Install documentation.
	dodoc AUTHORS COPYING NEWS README TODO
}
