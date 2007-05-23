# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/muse/muse-3.02.93.ebuild,v 1.5 2007/05/23 20:44:20 flameeyes Exp $

inherit elisp

IUSE=""

DESCRIPTION="Muse-mode is similar to EmacsWikiMode, but more focused on publishing to various formats."
HOMEPAGE="http://www.mwolson.org/projects/MuseMode.html"
SRC_URI="http://download.gna.org/muse-el/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~x86-fbsd"

DEPEND="virtual/emacs"

SITEFILE=50muse-mode-gentoo.el

S="${WORKDIR}/${P}"

src_compile() {
	emake || die
}

src_install() {
	doinfo muse.info
	dodoc README
	cp -r examples contrib experimental scripts ${D}/usr/share/doc/${PF}/
	elisp-install ${PN} lisp/*.el lisp/*.elc
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}
