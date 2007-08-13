# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/spidermonkey/spidermonkey-1.5-r2.ebuild,v 1.5 2007/08/13 20:17:49 dertobi123 Exp $

inherit eutils toolchain-funcs multilib

MY_P="js-${PV}"
DESCRIPTION="Stand-alone JavaScript C library"
HOMEPAGE="http://www.mozilla.org/js/spidermonkey/"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/js/${MY_P}.tar.gz"

LICENSE="NPL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="threadsafe"

S=${WORKDIR}/js/src

RDEPEND="threadsafe? ( dev-libs/nspr )"

DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.5-build.patch"
	epatch "${FILESDIR}/${PN}-1.5-threadsafe.diff"
	epatch "${FILESDIR}/${PN}-1.5-header.diff"
	if [[ ${CHOST} == *-freebsd* ]]; then
		# Don't try to be smart, this does not work in cross-compile anyway
		ln -s "${S}/config/Linux_All.mk" "${S}/config/$(uname -s)$(uname -r).mk"
	fi
}

src_compile() {
	tc-export CC LD AR
	if use threadsafe; then
		emake -j1 -f Makefile.ref LIBDIR="$(get_libdir)" JS_THREADSAFE=1 \
		|| die "emake with threadsafe enabled failed";
	else
		emake -j1 -f Makefile.ref LIBDIR="$(get_libdir)"\
		|| die "emake without threadsafe enabled failed";
	fi
}

src_install() {
	emake -f Makefile.ref install DESTDIR="${D}" LIBDIR="$(get_libdir)" || die
	dodoc ../jsd/README
	dohtml README.html
}
