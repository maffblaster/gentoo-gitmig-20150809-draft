# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/suacomp/suacomp-9999.ebuild,v 1.4 2011/09/03 08:40:58 scarabeus Exp $

EAPI=3

inherit toolchain-funcs flag-o-matic git

DESCRIPTION="library wrapping the interix lib-c to make it less buggy."
HOMEPAGE="http://suacomp.sf.net"
EGIT_REPO_URI="http://git.code.sf.net/p/suacomp/git"

LICENSE="BEER-WARE"
SLOT="0"
KEYWORDS=""
IUSE="debug"

DEPEND=""
RDEPEND=""

get_opts() {
	local shlibc=
	local stlibc=

	for dir in /usr/lib /usr/lib/x86; do
		[[ -f ${dir}/libc.a ]] && stlibc=${dir}/libc.a

		for name in libc.so.5.2 libc.so.3.5; do
			[[ -f ${dir}/${name} ]] && { shlibc=${dir}/${name}; break; }
		done

		[[ -f ${shlibc} && -f ${stlibc} ]] && break
	done

	echo "SHARED_LIBC=${shlibc} STATIC_LIBC=${stlibc}"
}

pkg_setup() {
	if use debug; then
		append-flags -D_DEBUG -D_DEBUG_TRACE
	fi
}

src_compile() {
	emake all CC=$(tc-getCC) $(get_opts) CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake install PREFIX="${EPREFIX}/usr" DESTDIR="${D}" $(get_opts) \
		CFLAGS="${CFLAGS}" || die "emake install failed"
}

src_test() {
	local v=

	use debug && v="TEST_VERBOSE=1"
	use debug && export SUACOMP_DEBUG_OUT=stderr

	emake check $(get_opts) ${v} || die "emake check failed"
}
