# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/ivtv-ptune/ivtv-ptune-0.2.0_rc3.ebuild,v 1.6 2006/02/13 14:50:21 mcummings Exp $

DESCRIPTION="ivtv tuner perl scripts"
HOMEPAGE="http://ivtv.sourceforge.net"

# stupidly named tarballs
MY_Pt="${P/-ptune/}"
MY_P="${MY_Pt/_/-}"

SRC_URI="http://205.209.168.201/~ckennedy/ivtv/${MY_P/1c/}/${MY_P}.tgz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE="X"

DEPEND="dev-perl/Video-Frequencies
	dev-perl/Video-ivtv
	virtual/perl-Getopt-Long
	dev-perl/Config-IniFiles
	X? ( dev-perl/perl-tk )"

src_compile() {
	echo
}

src_install() {
	cd ${WORKDIR}/${MY_P}/utils
	dobin ptune.pl record-v4l2.pl
	use X && dobin ptune-ui.pl
	newdoc README README.utils
	dodoc README.ptune
}
