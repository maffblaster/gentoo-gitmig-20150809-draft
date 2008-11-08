# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/enscript/enscript-1.6.4-r4.ebuild,v 1.4 2008/11/08 17:01:15 armin76 Exp $

inherit eutils

DESCRIPTION="powerful text-to-postscript converter"
SRC_URI="http://www.iki.fi/mtr/genscript/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/enscript/enscript.html"

KEYWORDS="alpha amd64 ~hppa ia64 ~mips ~ppc ~ppc64 sparc x86 ~x86-fbsd"
SLOT="0"
LICENSE="GPL-2"
IUSE="nls ruby"

DEPEND="sys-devel/flex
	sys-devel/bison
	nls? ( sys-devel/gettext )"
RDEPEND="nls? ( virtual/libintl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/enscript-1.6.3-security.patch
	epatch "${FILESDIR}"/enscript-1.6.3-language.patch
	epatch "${FILESDIR}"/enscript-catmur.patch
	epatch "${FILESDIR}"/enscript-1.6.4-ebuild.st.patch
	epatch "${FILESDIR}"/enscript-1.6.4-config.patch
	epatch "${FILESDIR}"/enscript-1.6.4-CVE-2008-3863-CVE-2008-4306.patch
	use ruby && epatch "${FILESDIR}"/enscript-1.6.2-ruby.patch
}

src_compile() {
	unset CC
	econf $(use_enable nls)
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS ChangeLog NEWS README* THANKS TODO || die "dodoc failed"

	insinto /usr/share/enscript/hl
	doins "${FILESDIR}"/ebuild.st || die "doins ebuild.st failed"

	if use ruby ; then
		insinto /usr/share/enscript/hl
		doins "${FILESDIR}"/ruby.st || die "doins ruby.st failed"
	fi
}

pkg_postinst() {
	elog "Now, customize /etc/enscript.cfg."
}
