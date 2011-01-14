# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/v8/v8-9999.ebuild,v 1.4 2011/01/14 12:44:43 phajdan.jr Exp $

EAPI="2"

inherit eutils flag-o-matic multilib scons-utils subversion toolchain-funcs

DESCRIPTION="Google's open source JavaScript engine"
HOMEPAGE="http://code.google.com/p/v8"
ESVN_REPO_URI="http://v8.googlecode.com/svn/trunk"
LICENSE="BSD"

SLOT="0"
KEYWORDS=""
IUSE="readline"

RDEPEND="readline? ( >=sys-libs/readline-6.1 )"
DEPEND="${RDEPEND}"

# To make tests work, we compile with sample=shell.
# For more info see http://groups.google.com/group/v8-users/browse_thread/thread/61ca70420e4476bc
EXTRA_ESCONS="library=shared sample=shell importenv=\"LINKFLAGS\""

pkg_setup() {
	tc-export AR CC CXX RANLIB

	# Make the build respect LDFLAGS.
	export LINKFLAGS="${LDFLAGS}"
}

src_prepare() {
	# Stop -Werror from breaking the build.
	epatch "${FILESDIR}"/${PN}-no-werror-r0.patch

	# Respect the user's CFLAGS, including the optimization level.
	epatch "${FILESDIR}"/${PN}-no-O3-r0.patch

	# Fix a compile error (bug #349794), to be upstreamed.
	epatch "${FILESDIR}"/${PN}-gentoo-bug-349794-r0.patch

	# Remove a test that is known to fail:
	# http://groups.google.com/group/v8-users/browse_thread/thread/b8a3f42b5aa18d06
	rm test/mjsunit/debug-script.js || die

	# Remove a test that behaves differently depending on FEATURES="userpriv",
	# see bug #348558.
	rm test/mjsunit/d8-os.js || die
}

src_configure() {
	# GCC issues multiple warnings about strict-aliasing issues in v8 code.
	append-flags -fno-strict-aliasing
}

src_compile() {
	local myconf=""

	# Use target arch detection logic from bug #296917.
	local myarch="$ABI"
	[[ $myarch = "" ]] && myarch="$ARCH"

	if [[ $myarch = amd64 ]] ; then
		myconf+=" arch=x64"
	elif [[ $myarch = x86 ]] ; then
		myconf+=" arch=ia32"
	elif [[ $myarch = arm ]] ; then
		myconf+=" arch=arm"
	else
		die "Failed to determine target arch, got '$myarch'."
	fi

	escons $(use_scons readline console readline dumb) ${myconf} . || die
}

src_install() {
	insinto /usr
	doins -r include || die

	dobin d8 || die
	dolib libv8.so || die

	dodoc AUTHORS ChangeLog || die
}

src_test() {
	tools/test.py --no-build -p dots || die
}

pkg_postinst() {
	einfo "The live ebuild does not use SONAME."
	einfo "You must rebuild all packages depending on ${PN}"
	einfo "to avoid ABI breakages."
}
