# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libtermcap-compat/libtermcap-compat-2.0.8-r2.ebuild,v 1.2 2006/09/20 23:13:45 vapier Exp $

# we only want this for binary-only packages, so we will only be installing
# the lib used at runtime; no headers and no files to link against

inherit eutils multilib

PATCHVER=0.1

MY_P="termcap-${PV}"
DESCRIPTION="Compatibility package for old termcap-based programs"
HOMEPAGE="http://www.catb.org/~esr/terminfo/"
SRC_URI="http://www.catb.org/~esr/terminfo/termtypes.tc.gz
	mirror://gentoo/${MY_P}.tar.bz2
	mirror://gentoo/${P}-gentoo-${PATCHVER}.tar.bz2"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}

	cd "${WORKDIR}"
	mv termtypes.tc termcap || die
	EPATCH_SOURCE="${WORKDIR}/patch"
	EPATCH_SUFFIX="patch"
	epatch "${EPATCH_SOURCE}"/tc.file

	cd "${S}"
	epatch "${FILESDIR}"/${PN}_bcopy_fix.patch
	epatch "${EPATCH_SOURCE}"
	epatch "${FILESDIR}"/${P}-fPIC.patch
}

src_compile() {
	emake prefix="/" CFLAGS="${CFLAGS} -I." || die
}

src_install() {
	dodir /lib /include
	emake prefix="${D}" OWNER="root:root" install || die
	dodoc ChangeLog README

	insinto /etc
	doins "${WORKDIR}"/termcap

	# now punt everything used for compiling
	cd "${D}"
	rm -r include || die

	mv lib $(get_libdir) || die
	dosym libtermcap.so.${PV} /$(get_libdir)/libtermcap.so.2
	cd $(get_libdir)
	rm -f libtermcap.{a,so}
}
