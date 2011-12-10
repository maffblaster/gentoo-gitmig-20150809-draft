# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mingw-runtime/mingw-runtime-3.20.ebuild,v 1.1 2011/12/10 20:58:08 vapier Exp $

export CBUILD=${CBUILD:-${CHOST}}
export CTARGET=${CTARGET:-${CHOST}}
if [[ ${CTARGET} == ${CHOST} ]] ; then
	if [[ ${CATEGORY/cross-} != ${CATEGORY} ]] ; then
		export CTARGET=${CATEGORY/cross-}
	fi
fi

inherit flag-o-matic

MY_P="mingwrt-${PV}-mingw32"
DESCRIPTION="Free Win32 runtime and import library definitions"
HOMEPAGE="http://www.mingw.org/"
# http://sourceforge.net/projects/mingw/files/MinGW/Base/mingw-rt/
SRC_URI="mirror://sourceforge/mingw/${MY_P}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="crosscompile_opts_headers-only"
RESTRICT="strip"

S=${WORKDIR}/${MY_P}

is_crosscompile() {
	[[ ${CHOST} != ${CTARGET} ]]
}
just_headers() {
	use crosscompile_opts_headers-only && [[ ${CHOST} != ${CTARGET} ]]
}

pkg_setup() {
	if [[ ${CBUILD} == ${CHOST} ]] && [[ ${CHOST} == ${CTARGET} ]] ; then
		die "Invalid configuration"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "/W32API_INCLUDE/s:=.*:='-I /usr/${CTARGET}/usr/include':" \
		$(find -name configure) || die
	sed -i \
		-e '/^install_dlls_host:/s:$: install-dirs:' \
		Makefile.in || die # fix parallel install
}

src_compile() {
	just_headers && return 0

	CHOST=${CTARGET} strip-unsupported-flags
	econf --host=${CTARGET} || die
	emake || die
}

src_install() {
	if just_headers ; then
		insinto /usr/${CTARGET}/usr/include
		doins -r include/* || die
	else
		local insdir
		is_crosscompile \
			&& insdir="${D}/usr/${CTARGET}" \
			|| insdir="${D}"
		emake install DESTDIR="${insdir}" || die
		env -uRESTRICT CHOST=${CTARGET} prepallstrip
		rm -rf "${insdir}"/usr/doc
		dodoc CONTRIBUTORS ChangeLog README TODO readme.txt
	fi
	is_crosscompile && dosym usr /usr/${CTARGET}/mingw
}
