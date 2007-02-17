# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ocaml/ocaml-3.08.3.ebuild,v 1.16 2007/02/17 19:16:10 grobian Exp $

inherit flag-o-matic eutils multilib

DESCRIPTION="fast modern type-inferring functional programming language descended from the ML (Meta Language) family"
HOMEPAGE="http://www.ocaml.org/"

SRC_URI="http://caml.inria.fr/distrib/ocaml-3.08/${P}.tar.bz2"

LICENSE="QPL-1.0 LGPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="tk latex"

DEPEND="virtual/libc
	tk? ( >=dev-lang/tk-3.3.3 )"

pkg_setup() {
	ewarn
	ewarn "Building ocaml with unsafe CFLAGS can have unexpected results"
	ewarn "Please retry building with safer CFLAGS before reporting bugs"
	ewarn
}

src_unpack() {
	unpack ${A}
	cd ${S}

	#GCC4 patch
	epatch ${FILESDIR}/${P}-gcc4.patch
}

src_compile() {
	filter-flags "-fstack-protector"
	replace-flags "-O?" -O2

	local myconf
	use tk || myconf="-no-tk"

	# Fix for bug #23767.
	if [ "${ARCH}" = "sparc" ]; then
		myconf="${myconf} -host sparc-unknown-linux-gnu"
	fi

	# Fix for bug #46703
	export LC_ALL=C

	./configure -prefix /usr \
		-bindir /usr/bin \
		-libdir /usr/$(get_libdir)/ocaml \
		-mandir /usr/share/man \
		--with-pthread ${myconf} || die

	sed -i -e "s/\(BYTECCCOMPOPTS=.*\)/\1 ${CFLAGS}/" config/Makefile
	sed -i -e "s/\(NATIVECCCOMPOPTS=.*\)/\1 ${CFLAGS}/" config/Makefile

	make world || die

	# Native code generation unsupported on some archs
	if ! use ppc64 ; then
		make opt || die
		make opt.opt || die
	fi
}

src_install() {
	make BINDIR=${D}/usr/bin \
		LIBDIR=${D}/usr/$(get_libdir)/ocaml \
		MANDIR=${D}/usr/share/man \
		install || die

	# silly, silly makefiles
	dosed "s:${D}::g" /usr/$(get_libdir)/ocaml/ld.conf

	# documentation
	dodoc Changes INSTALL LICENSE README Upgrading
}

pkg_postinst() {
	if use latex; then
		echo "TEXINPUTS=/usr/$(get_libdir)/ocaml/ocamldoc:" > /etc/env.d/99ocamldoc
	fi

	echo
	elog "OCaml is not binary compatible from version to version,"
	elog "so you (may) need to rebuild all packages depending on it that"
	elog "are actually installed on your system."
	elog "To do so, you can run: "
	elog "sh ${FILESDIR}/ocaml-rebuild.sh [-h | emerge options]"
	elog "Which will call emerge on all old packages with the given options"
	echo
}
