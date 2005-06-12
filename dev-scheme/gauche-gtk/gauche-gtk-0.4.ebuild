# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/gauche-gtk/gauche-gtk-0.4.ebuild,v 1.3 2005/06/12 14:28:34 swegener Exp $

inherit eutils flag-o-matic

IUSE="glgd nls opengl"

MY_P="${P/g/G}"

DESCRIPTION="GTK2 binding for Gauche"
HOMEPAGE="http://gauche.sf.net/"
SRC_URI="mirror://sourceforge/gauche/${MY_P}.tgz"

RESTRICT="nomirror"
LICENSE="BSD"
KEYWORDS="x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"
RDEPEND=">=x11-libs/gtk+-2
	>=dev-lang/gauche-0.7.4.1
	opengl? ( >=x11-libs/gtkglext-0.6.0 )"

src_compile() {

	local myconf myflags

	if use opengl; then
		if use glgd; then
			myconf="--enable-glgd"

			if use nls; then
				myconf="${myconf}-pango"
			fi
		else
			myconf="--enable-gtkgl"
		fi
	fi

	strip-flags

	myflags=${CFLAGS}
	unset CFLAGS CXXFLAGS

	econf ${myconf} || die
	emake OPTFLAGS="${myflags}" || die

}

src_install() {

	dodir $(gauche-config --syslibdir)
	dodir $(gauche-config --sysincdir)
	dodir $(gauche-config --sysarchdir)

	make DESTDIR=${D} install || die

	dodoc ChangeLog README COPYING


	docinto examples
	for f in examples/*; do
		[ -f ${f} ] && dodoc ${f}
	done

	docinto examples/gtk-tutorial
	dodoc examples/gtk-tutorial/*

	if use opengl; then
		docinto examples/gtkglext
		dodoc examples/gtkglext/*

		if use glgd; then
			docinto examples/glgd
			dodoc examples/glgd/*

			docinto
			newdoc glgd/README README.glgd
			newdoc glgd/README.eucjp README.eucjp.glgd
		fi
	fi

}

pkg_postinst() {

	if use opengl; then
		einfo "If you want to use OpenGL with Gauche, please emerge Gauche-gl."
	fi

}
