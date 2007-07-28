# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knutclient/knutclient-0.9.1.ebuild,v 1.6 2007/07/28 09:18:56 philantrop Exp $

inherit kde

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Client for the NUT UPS monitoring daemon"
HOMEPAGE="http://www.knut.noveradsl.cz/knutclient/"
SRC_URI="ftp://ftp.buzuluk.cz/pub/alo/knutclient/stable/${MY_P}.tar.gz
	mirror://gentoo/kde-admindir-3.5.5.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE=""

need-kde 3.5

PATCHES="${FILESDIR}/knutclient-0.9.diff"
