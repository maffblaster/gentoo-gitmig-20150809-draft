# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/cmfboard/cmfboard-1.4.3.ebuild,v 1.3 2004/06/25 01:18:09 agriffis Exp $

inherit zproduct

DESCRIPTION="Zope/CMF product which provides a forum"
HOMEPAGE="http://www.cmfboard.org"
SRC_URI="http://www.cmfboard.org/download/CMFBoard-${PV}.tar.gz"
LICENSE="ZPL"
KEYWORDS="~x86 ~ppc"
RDEPEND=">=net-zope/cmf-1.3.3
	>=net-zope/plone-1.0.5
	>=net-zope/archetypes-1.0.1
	${RDEPEND}"

ZPROD_LIST="CMFBoard"
