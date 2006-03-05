# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-apps/horde-turba/horde-turba-2.0.5.ebuild,v 1.2 2006/03/05 16:06:25 vapier Exp $

HORDE_PHP_FEATURES="-o mysql mysqli odbc postgres ldap"
HORDE_MAJ="-h3"
inherit horde

DESCRIPTION="Turba is the Horde address book / contact management program"

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

DEPEND=""
RDEPEND=">=www-apps/horde-3"
