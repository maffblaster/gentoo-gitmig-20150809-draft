# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/pop2imap/pop2imap-1.18.ebuild,v 1.3 2011/07/18 15:22:58 hwoarang Exp $

EAPI=4

DESCRIPTION="Synchronize mailboxes between a pop and an imap servers"
HOMEPAGE="http://www.linux-france.org/prj/pop2imap/"
SRC_URI="http://www.linux-france.org/prj/pop2imap/dist/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl
	dev-perl/Mail-POP3Client
	dev-perl/Mail-IMAPClient
	dev-perl/Email-Simple
	dev-perl/DateManip
	dev-perl/IO-Socket-SSL"

src_install(){
	dobin pop2imap
	dodoc ChangeLog README VERSION
}
