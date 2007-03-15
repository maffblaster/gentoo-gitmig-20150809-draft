# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-words/twisted-words-0.4.0-r1.ebuild,v 1.11 2007/03/15 16:36:01 corsair Exp $

MY_PACKAGE=Words

inherit twisted

DESCRIPTION="Twisted Words contains Instant Messaging implementations."

KEYWORDS="alpha amd64 hppa ia64 ~ppc ppc64 sparc x86"

DEPEND="=dev-python/twisted-2.4*
	dev-python/twisted-web"

IUSE=""


src_install() {
	twisted_src_install

	# Remove the "im" script we do not depend on the required pygtk.
	rm -rf "${D}"/usr/{bin,share/man}
}
