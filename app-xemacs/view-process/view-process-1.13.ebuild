# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/view-process/view-process-1.13.ebuild,v 1.2 2007/05/30 09:57:05 armin76 Exp $

SLOT="0"
IUSE=""
DESCRIPTION="A Unix process browsing tool."
PKG_CAT="standard"

RDEPEND="app-xemacs/xemacs-base
"
KEYWORDS="alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"

inherit xemacs-packages

