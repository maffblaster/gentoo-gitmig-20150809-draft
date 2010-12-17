# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tcltk/expect/expect-5.45.ebuild,v 1.1 2010/12/17 23:23:44 vapier Exp $

EAPI="3"

inherit autotools eutils

MY_P="${PN}${PV}"
DESCRIPTION="tool for automating interactive applications"
HOMEPAGE="http://expect.nist.gov/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-macos ~x86-solaris"
IUSE="debug doc threads"

# We need dejagnu for src_test, but dejagnu needs expect
# to compile/run, so we cant add dejagnu to DEPEND :/
DEPEND=">=dev-lang/tcl-8.2[threads?]"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i "s:/usr/local/bin:${EPREFIX}/usr/bin:" expect.man || die
	# stops any example scripts being installed by default
	sed -i \
		-e '/^install:/s/install-libraries //' \
		-e 's/^SCRIPTS_MANPAGES = /_&/' \
		Makefile.in

	epatch "${FILESDIR}"/${PN}-5.45-gfbsd.patch
	epatch "${FILESDIR}"/${PN}-5.44.1.15-ldflags.patch
	epatch "${FILESDIR}"/${PN}-5.45-headers.patch #337943
	sed -i 's:ifdef HAVE_SYS_WAIT_H:ifndef NO_SYS_WAIT_H:' *.c

	eautoconf
}

src_configure() {
	# the 64bit flag is useless ... it only adds 64bit compiler flags
	# (like -m64) which the target toolchain should already handle
	econf \
		--with-tcl=${EPREFIX}/usr/$(get_libdir) \
		--disable-64bit \
		--enable-shared \
		$(use_enable threads) \
		$(use_enable debug symbols mem)
}

src_test() {
	# we need dejagnu to do tests ... but dejagnu needs
	# expect ... so don't do tests unless we have dejagnu
	type -p runtest || return 0
	emake test || die
}

expect_make_var() {
	touch pkgIndex.tcl-hand
	printf 'all:;echo $('$1')\ninclude Makefile' | emake --no-print-directory -s -f -
	rm -f pkgIndex.tcl-hand
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc ChangeLog FAQ HISTORY NEWS README

	if use doc ; then
		docinto examples
		dodoc \
			example/README \
			$(printf 'example/%s ' $(expect_make_var SCRIPTS)) \
			$(printf 'example/%s.man ' $(expect_make_var _SCRIPTS_MANPAGES)) \
			|| die
	fi
}
