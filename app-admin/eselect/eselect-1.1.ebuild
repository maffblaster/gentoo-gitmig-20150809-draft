# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect/eselect-1.1.ebuild,v 1.2 2009/06/02 22:32:11 ulm Exp $

DESCRIPTION="Gentoo's multi-purpose configuration and management tool"
HOMEPAGE="http://www.gentoo.org/proj/en/eselect/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="doc bash-completion paludis"

RDEPEND="sys-apps/sed
	|| (
		sys-apps/coreutils
		sys-freebsd/freebsd-bin
		app-admin/realpath
	)"
DEPEND="${RDEPEND}
	doc? ( dev-python/docutils )"
RDEPEND="${RDEPEND}
	sys-apps/file
	sys-libs/ncurses
	!paludis? ( >=sys-apps/portage-2.1.6 )"

# Commented out: only few users of eselect will edit its source
#PDEPEND="emacs? ( app-emacs/gentoo-syntax )
#	vim-syntax? ( app-vim/eselect-syntax )"

src_compile() {
	econf --with-pm="$(usev paludis || echo portage)"
	emake || die "emake failed"

	if use doc ; then
		make html || die "failed to build html"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README TODO doc/*.txt
	use doc && dohtml *.html doc/*

	# needed by news-tng module
	keepdir /var/lib/gentoo/news

	# we don't use bash-completion.eclass since eselect
	# is listed in RDEPEND.
	if use bash-completion ; then
		insinto /usr/share/bash-completion
		newins misc/${PN}.bashcomp ${PN} || die
	fi
}

pkg_postinst() {
	# fowners in src_install doesn't work for the portage group:
	# merging changes the group back to root
	chgrp portage "${ROOT}/var/lib/gentoo/news" \
		&& chmod g+w "${ROOT}/var/lib/gentoo/news"

	# we cannot properly depend on paludis because of circular dependencies
	if use paludis && ! has_version sys-apps/paludis; then
		ewarn "You have emerged ${PN} with the \"paludis\" USE flag enabled,"
		ewarn "but apparently Paludis is not installed on your system."
		ewarn "Part of eselect's functionality may therefore be missing."
	fi

	if use bash-completion ; then
		elog "In case you have not yet enabled command-line completion"
		elog "for eselect, you can run:"
		elog
		elog "  eselect bashcomp enable eselect"
		elog
		elog "to install locally, or"
		elog
		elog "  eselect bashcomp enable --global eselect"
		elog
		elog "to install system-wide."
	fi
}
