# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/gcc/gcc-4.2.0_alpha20060506.ebuild,v 1.2 2006/05/10 03:14:29 vapier Exp $

ETYPE="gcc-compiler"

inherit toolchain

DESCRIPTION="The GNU Compiler Collection.  Includes C/C++, java compilers, pie+ssp extensions, Haj Ten Brugge runtime bounds checking"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="-*"

RDEPEND=">=sys-libs/zlib-1.1.4
	|| ( app-admin/eselect-compiler >=sys-devel/gcc-config-1.3.12-r4 )
	virtual/libiconv
	fortran? (
	  dev-libs/gmp
	  dev-libs/mpfr
	)
	!build? (
		gcj? (
			gtk? (
				|| ( ( x11-libs/libXt x11-libs/libX11 x11-libs/libXtst x11-proto/xproto x11-proto/xextproto ) virtual/x11 )
				>=x11-libs/gtk+-2.2
				x11-libs/pango
			)
			>=media-libs/libart_lgpl-2.1
		)
		>=sys-libs/ncurses-5.2-r2
		nls? ( sys-devel/gettext )
	)"
if [[ ${CATEGORY} != cross-* ]] ; then
	RDEPEND="${RDEPEND} elibc_glibc? (
	hppa? ( >=sys-libs/glibc-2.3.4 ) !hppa? ( >=sys-libs/glibc-2.3.6 )
	)"
fi
DEPEND="${RDEPEND}
	>=sys-apps/texinfo-4.2-r4
	>=sys-devel/bison-1.875
	>=${CATEGORY}/binutils-2.16.1"

PDEPEND="|| ( app-admin/eselect-compiler sys-devel/gcc-config )
	x86? ( !nocxx? ( !elibc_uclibc? ( !build? ( =virtual/libstdc++-3.3 ) ) ) )"

pkg_setup() {
	if [[ -z ${I_PROMISE_TO_SUPPLY_PATCHES_WITH_BUGS} ]] ; then
		die "Please \`export I_PROMISE_TO_SUPPLY_PATCHES_WITH_BUGS=1\` or define it in your make.conf if you want to use this ebuild.  This is to try and cut down on people filing bugs for a compiler we do not currently support."
	fi
}

src_unpack() {
	gcc_src_unpack

	# Fix cross-compiling
	epatch "${FILESDIR}"/4.0.2/gcc-4.0.2-cross-compile.patch
}

pkg_postinst() {
	toolchain_pkg_postinst

	einfo "This gcc-4 ebuild is provided for your convenience, and the use"
	einfo "of this compiler is not supported by the Gentoo Developers."
	einfo "Please file bugs related to gcc-4 with upstream developers."
	einfo "Compiler bugs should be filed at http://gcc.gnu.org/bugzilla/"
}
