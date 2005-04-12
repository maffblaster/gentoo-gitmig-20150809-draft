# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils/binutils-2.16.90.0.1.ebuild,v 1.1 2005/04/12 04:46:31 vapier Exp $

PATCHVER="1.0"
UCLIBC_PATCHVER="1.0"
inherit toolchain-binutils

KEYWORDS="-*"

src_unpack() {
	toolchain-binutils_src_unpack

	# Patches
	cd "${WORKDIR}"/patch
	#mv 63* skip/

	apply_binutils_updates
}
