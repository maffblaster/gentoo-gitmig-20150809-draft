# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope-browserresource/zope-browserresource-3.10.2.ebuild,v 1.1 2009/11/29 00:12:23 arfrever Exp $

EAPI="2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils

MY_PN="${PN/-/.}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Browser resources implementation for Zope."
HOMEPAGE="http://pypi.python.org/pypi/zope.browserresource"
SRC_URI="http://pypi.python.org/packages/source/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="ZPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="net-zope/zope-component
	net-zope/zope-configuration
	net-zope/zope-contenttype
	net-zope/zope-i18n
	net-zope/zope-interface
	net-zope/zope-location
	net-zope/zope-publisher
	net-zope/zope-schema
	net-zope/zope-security
	net-zope/zope-traversing"
DEPEND="${RDEPEND}
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="${PN/-//}"
DOCS="CHANGES.txt README.txt"
