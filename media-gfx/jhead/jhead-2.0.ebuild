# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/jhead/jhead-2.0.ebuild,v 1.11 2004/07/01 10:49:20 eradicator Exp $

DESCRIPTION="Exif Jpeg camera setting parser and thumbnail remover"
HOMEPAGE="http://www.sentex.net/~mwandel/jhead/"
SRC_URI="http://www.sentex.net/~mwandel/jhead/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="x86 ppc sparc ~amd64 alpha ia64 hppa"

DEPEND="virtual/libc"

src_compile() {
	emake || die
}

src_install() {
	dobin jhead || die
	dodoc readme.txt changes.txt
	dohtml usage.html
	doman jhead.1.gz
}
