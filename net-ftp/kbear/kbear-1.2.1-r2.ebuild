# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Philippe Namias <pnamias@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kbear/kbear-1.2.1-r2.ebuild,v 1.2 2002/03/15 15:32:22 danarmak Exp $
. /usr/portage/eclass/inherit.eclass
inherit kde-base || die

DESCRIPTION="An FTP Manager"
SRC_URI="http://download.sourceforge.net/kbear/${P}.src.tar.bz2"
HOMEPAGE="http://kbear.sourceforge.net"

need-kde 2.1.1

src_unpack() {

    base_src_unpack all patch

}