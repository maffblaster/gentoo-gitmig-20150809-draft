# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pycrash/pycrash-0.4_pre2.ebuild,v 1.1 2004/05/08 15:51:35 kloeri Exp $

inherit distutils

S="${WORKDIR}/${MY_P}"

MY_P="PyCrash-${PV/_/-}"
DESCRIPTION="PyCrash: a Run-Time Exception Dumper for Python programs"
HOMEPAGE="http://www.pycrash.org/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""
KEYWORDS="~x86"
DOCS="NEWS TODO"

DEPEND=">=virtual/python-2.3"
