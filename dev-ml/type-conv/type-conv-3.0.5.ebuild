# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/type-conv/type-conv-3.0.5.ebuild,v 1.1 2012/06/30 12:34:52 aballier Exp $

EAPI="3"

inherit oasis

DESCRIPTION="Mini library required for some other preprocessing libraries"
HOMEPAGE="http://forge.ocamlcore.org/projects/type-conv/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/821/${P}.tar.gz"

LICENSE="LGPL-2.1-linking-exception"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

DOCS=( "README.txt" "Changelog" )

S="${WORKDIR}/${PN/-/_}-${PV}"
