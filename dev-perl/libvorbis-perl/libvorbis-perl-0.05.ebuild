# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/libvorbis-perl/libvorbis-perl-0.05.ebuild,v 1.1 2005/04/29 17:40:48 mcummings Exp $

inherit perl-module

DESCRIPTION="Ogg::Vorbis - Perl extension for Ogg Vorbis streams"
SRC_URI_BASE="mirror://cpan/authors/id/F/FO/FOOF"
SRC_URI="${SRC_URI_BASE}/${P}.tar.gz"
HOMEPAGE="http://synthcode.com/code/vorbis/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~sparc ~ppc ~amd64"
IUSE=""

DEPEND="${DEPEND}
	media-libs/libogg
	media-libs/libvorbis"
