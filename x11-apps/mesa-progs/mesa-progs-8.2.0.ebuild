# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/mesa-progs/mesa-progs-8.2.0.ebuild,v 1.14 2015/03/14 13:55:51 maekke Exp $

EAPI=5

MY_PN=${PN/progs/demos}
MY_P=${MY_PN}-${PV}
EGIT_REPO_URI="git://anongit.freedesktop.org/${MY_PN/-//}"

if [[ ${PV} = 9999* ]]; then
	GIT_ECLASS="git-r3"
	EXPERIMENTAL="true"
fi

inherit base autotools toolchain-funcs ${GIT_ECLASS}

DESCRIPTION="Mesa's OpenGL utility and demo programs (glxgears and glxinfo)"
HOMEPAGE="http://mesa3d.sourceforge.net/"
if [[ ${PV} == 9999* ]]; then
	SRC_URI=""
else
	SRC_URI="ftp://ftp.freedesktop.org/pub/${MY_PN/-//}/${PV}/${MY_P}.tar.bz2"
fi

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ~arm64 hppa ia64 ~mips ppc ppc64 ~sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux"
IUSE="egl gles1 gles2"

RDEPEND="
	media-libs/freeglut
	media-libs/glew
	media-libs/mesa[egl?,gles1?,gles2?]
	virtual/opengl
	x11-libs/libX11"
DEPEND="${RDEPEND}
	virtual/glu
	x11-proto/xproto"

S=${WORKDIR}/${MY_P}
EGIT_CHECKOUT_DIR=${S}

src_unpack() {
	default
	[[ $PV = 9999* ]] && git-r3_src_unpack
}

src_prepare() {
	base_src_prepare

	eautoreconf
}

src_compile() {
	emake -C src/xdemos glxgears glxinfo

	if use egl; then
		emake LDLIBS="-lEGL" -C src/egl/opengl/ eglinfo
		emake -C src/egl/eglut/ libeglut_screen.la libeglut_x11.la
		emake LDLIBS="-lGL -lEGL -lX11 -lm" -C src/egl/opengl/ eglgears_x11
		emake LDLIBS="-lGL -lEGL -lm" -C src/egl/opengl/ eglgears_screen

		if use gles1; then
			emake LDLIBS="-lGLESv1_CM -lEGL -lX11" -C src/egl/opengles1/ es1_info
			emake LDLIBS="-lGLESv1_CM -lEGL -lX11 -lm" -C src/egl/opengles1/ gears_x11
			emake LDLIBS="-lGLESv1_CM -lEGL -lm" -C src/egl/opengles1/ gears_screen
		fi
		if use gles2; then
			emake LDLIBS="-lGLESv2 -lEGL -lX11" -C src/egl/opengles2/ es2_info
			emake LDLIBS="-lGLESv2 -lEGL -lX11 -lm" -C src/egl/opengles2/ es2gears_x11
			emake LDLIBS="-lGLESv2 -lEGL -lm" -C src/egl/opengles2/ es2gears_screen
		fi
	fi
}

src_install() {
	dobin src/xdemos/{glxgears,glxinfo}
	if use egl; then
		dobin src/egl/opengl/egl{info,gears_{screen,x11}}

		if use gles1; then
			dobin src/egl/opengles1/es1_info
			newbin src/egl/opengles1/gears_screen es1gears_screen
			newbin src/egl/opengles1/gears_x11 es1gears_x11
		fi

		use gles2 && dobin src/egl/opengles2/es2{_info,gears_{screen,x11}}
	fi
}
