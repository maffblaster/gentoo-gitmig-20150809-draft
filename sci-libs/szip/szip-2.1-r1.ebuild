# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/szip/szip-2.1-r1.ebuild,v 1.2 2012/06/26 23:07:51 bicatali Exp $

EAPI=4
inherit autotools-utils

DESCRIPTION="Extended-Rice lossless compression algorithm implementation"
HOMEPAGE="http://www.hdfgroup.org/doc_resource/SZIP/"
SRC_URI="ftp://ftp.hdfgroup.org/lib-external/${PN}/${PV}/src/${P}.tar.gz"
LICENSE="szip"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~amd64-linux ~x86-linux"

IUSE="static-libs"
RDEPEND=""
DEPEND="${RDEPEND}"

DOCS=( RELEASE.txt HISTORY.txt examples/example.c )
