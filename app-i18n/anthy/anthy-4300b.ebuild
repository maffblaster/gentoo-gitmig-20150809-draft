# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/anthy/anthy-4300b.ebuild,v 1.6 2003/11/24 15:02:38 usata Exp $

inherit elisp-common

IUSE="emacs"

DESCRIPTION="Anthy -- free and secure Japanese input system"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/5332/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 alpha sparc"
SLOT="0"

S="${WORKDIR}/${P}"

DEPEND="virtual/glibc
	!app-i18n/anthy-ss
	emacs? ( virtual/emacs )"

SITEFILE="50anthy-gentoo.el"

src_compile() {

	econf `use emacs >/dev/null 2>&1 || echo EMACS=no` || die
	emake || die
}

src_install() {

	einstall || die

	use emacs && elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc AUTHORS ChangeLog DIARY INSTALL NEWS README \
		doc/[A-Z][A-Z]* doc/protocol.txt
}

pkg_postinst() {

	use emacs && elisp-site-regen
}

pkg_postrm() {

	use emacs && elisp-site-regen
}
