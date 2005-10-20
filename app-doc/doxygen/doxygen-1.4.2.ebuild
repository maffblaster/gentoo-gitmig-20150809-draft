# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/doxygen/doxygen-1.4.2.ebuild,v 1.12 2005/10/20 06:34:43 nerdboy Exp $

inherit eutils

DESCRIPTION="Documentation and analysis tool for C++, C, Java, IDL, PHP and C#"
HOMEPAGE="http://www.doxygen.org/"
SRC_URI="ftp://ftp.stack.nl/pub/users/dimitri/${P}.src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc-macos ppc64 s390 sparc x86"
IUSE="doc qt tetex"

DEPEND="media-gfx/graphviz
	qt? ( =x11-libs/qt-3* )
	tetex? ( virtual/tetex )
	virtual/ghostscript
	>=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}
	# use CFLAGS and CXXFLAGS
	sed -i.orig -e "s:^\(TMAKE_CFLAGS_RELEASE\t*\)= .*$:\1= ${CFLAGS}:" \
		-e "s:^\(TMAKE_CXXFLAGS_RELEASE\t*\)= .*$:\1= ${CXXFLAGS}:" \
		tmake/lib/linux-g++/tmake.conf
	if use userland_Darwin; then
		epatch ${FILESDIR}/bsd-configure.patch
		[[ "$MACOSX_DEPLOYMENT_TARGET" == "10.4" ]] &&  sed -i -e 's:-D__FreeBSD__:-D__FreeBSD__=5:' \
		tmake/lib/macosx-c++/tmake.conf
	fi
}

src_compile() {
	# set ./configure options (prefix, Qt based wizard, docdir)
	local confopts="--prefix ${D}usr"
	use qt && confopts="${confopts} --with-doxywizard"

	# ./configure and compile
	./configure ${confopts} || die '"./configure" failed.'
	make DESTDIR="${D}" all || die '"make all" failed.'

	# generate html and pdf (if tetex in use) documents.
	# errors here are not considered fatal, hence the ewarn message
	# TeX's font caching in /var/cache/fonts causes sandbox warnings,
	# so we allow it.
	if use doc; then
		if use tetex; then
			addwrite /var/cache/fonts
			addwrite /usr/share/texmf/fonts/pk
			addwrite /usr/share/texmf/ls-R
			make pdf || ewarn '"make docs" failed.'
		else
			cp doc/Doxyfile doc/Doxyfile.orig
			cp doc/Makefile doc/Makefile.orig
			sed -i.orig -e "s/GENERATE_LATEX    = YES/GENERATE_LATEX    = NO/" doc/Doxyfile
			sed -i.orig -e "s/@epstopdf/# @epstopdf/" \
				-e "s/@cp Makefile.latex/# @cp Makefile.latex/" \
				-e "s/@sed/# @sed/" doc/Makefile
			make docs || ewarn '"make docs" failed.'
		fi
	fi
}

src_install() {
	make DESTDIR=${D} MAN1DIR=share/man/man1 \
		install || die '"make install" failed.'

	dodoc INSTALL LANGUAGE.HOWTO LICENSE README VERSION

	# pdf and html manuals
	if use doc; then
		insinto /usr/share/doc/${PF}
		if use tetex; then
			doins latex/doxygen_manual.pdf
		fi
		dohtml -r html/*
	fi
}

pkg_postinst() {

	ewarn
	einfo "The USE flags qt, doc, and tetex will enable doxywizard, or"
	einfo "the html and pdf documentation, respectively.  For examples"
	einfo "and other goodies, see the source tarball.  For some example"
	einfo "output, run doxygen on the doxygen source using the Doxyfile"
	einfo "provided in the top-level source dir."
	ewarn
}
