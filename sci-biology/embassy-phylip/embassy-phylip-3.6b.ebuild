# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/embassy-phylip/embassy-phylip-3.6b.ebuild,v 1.9 2008/08/27 17:48:49 ribosome Exp $

EBOV="5.0.0"

inherit embassy

DESCRIPTION="EMBOSS integrated version of PHYLIP - The Phylogeny Inference Package"
LICENSE="freedist"
SRC_URI="ftp://emboss.open-bio.org/pub/EMBOSS/EMBOSS-${EBOV}.tar.gz
	mirror://gentoo/embassy-${EBOV}-${PN:8}-${PV}.tar.gz"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"
