# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-xemacs/tm/tm-1.39.ebuild,v 1.5 2011/07/03 08:10:19 hwoarang Exp $

SLOT="0"
IUSE=""
DESCRIPTION="Emacs MIME support. Not needed for gnus >= 5.8.0"
PKG_CAT="standard"

RDEPEND="app-xemacs/gnus
app-xemacs/mh-e
app-xemacs/rmail
app-xemacs/vm
app-xemacs/mailcrypt
app-xemacs/mail-lib
app-xemacs/apel
app-xemacs/xemacs-base
app-xemacs/fsf-compat
app-xemacs/sh-script
app-xemacs/net-utils
app-xemacs/ecrypto
"
KEYWORDS="alpha amd64 ppc ~ppc64 sparc x86"

inherit xemacs-packages
