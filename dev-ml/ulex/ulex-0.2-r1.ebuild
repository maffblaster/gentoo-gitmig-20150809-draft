# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ulex/ulex-0.2-r1.ebuild,v 1.2 2004/05/28 15:41:00 vapier Exp $

inherit eutils

DESCRIPTION="a lexer generator for unicode"
HOMEPAGE="http://www.cduce.org"
SRC_URI="http://www.cduce.org/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.06
	>=dev-ml/findlib-0.8"

src_compile() {
	epatch ${FILESDIR}/${P}-Makefile.patch
	make all || die
	make all.opt || die
}

src_install() {
	local destdir=`ocamlfind printconf destdir`
	dodir ${destdir}
	# dummy ld.conf, packages do not install C libraries
	make OCAMLFIND_LDCONF=dummy OCAMLFIND_DESTDIR=${D}${destdir} install || die
	dodoc README CHANGES
}
