# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ant/ant-1.7.0.ebuild,v 1.1 2007/01/21 23:31:49 caster Exp $

DESCRIPTION="Java-based build tool similar to 'make' that uses XML configuration files."
HOMEPAGE="http://ant.apache.org/"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="~dev-java/ant-core-${PV}
	~dev-java/ant-tasks-${PV}"
RDEPEND="${DEPEND}"
