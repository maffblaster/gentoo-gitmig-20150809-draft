# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/gnats/gnats-1.15.ebuild,v 1.3 2003/02/13 09:53:35 vapier Exp $

SLOT="0"
IUSE=""
DESCRIPTION="XEmacs bug reports."
PKG_CAT="standard"

DEPEND="app-xemacs/mail-lib
app-xemacs/xemacs-base
"
KEYWORDS="x86 -ppc alpha sparc"

inherit xemacs-packages

