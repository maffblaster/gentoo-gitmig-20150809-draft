# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pkgcore/pkgcore-0.3.ebuild,v 1.5 2007/06/07 14:02:59 corsair Exp $

inherit distutils eutils

DESCRIPTION="pkgcore package manager"
HOMEPAGE="http://www.pkgcore.org"
SRC_URI="http://www.pkgcore.org/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ia64 ~ppc64 ~sparc ~x86"
IUSE="doc"

RDEPEND=">=dev-lang/python-2.4
	dev-python/snakeoil
	>=app-shells/bash-3.0
	|| ( >=dev-lang/python-2.5 dev-python/pycrypto )"
DEPEND="${RDEPEND}
	doc? ( >=dev-python/docutils-0.4 )"

DOCS="AUTHORS NEWS"

src_unpack() {
	unpack ${A}
	cd "${S}"
	use hppa && epatch "${FILESDIR}/${PN}-0.2-hppa-disable-filter-env.patch"

	epatch "${FILESDIR}/${P}-pmerge-unmerge-ask.patch"
}

src_compile() {
	distutils_src_compile

	if use doc; then
		./build_docs.py || die "doc building failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml -r doc dev-notes
		doman man/*.1
	fi

	dodoc doc/*.rst man/*.rst
	docinto dev-notes
	dodoc dev-notes/*.rst
}

pkg_postinst() {
	distutils_pkg_postinst
	pplugincache

	if [[ -d "${ROOT}etc/pkgcore/plugins" ]]; then
		elog "You still have an /etc/pkgcore/plugins from pkgcore 0.1."
		elog "It is unused by pkgcore >= 0.2, so you can remove it now."
	fi

	# This is left behind by pkgcore 0.2.
	rm -f "${ROOT}"usr/$(get_libdir)/python${PYVER}/site-packages/pkgcore/plugins/plugincache

	elog "If the new layman sync support causes problems you can disable it"
	elog "with FEATURES=-layman-sync. If you cannot sync a layman overlay"
	elog "using pkgcore, file a bug in pkgcore.org trac instead of complaining"
	elog "to the layman or overlay maintainer."
}

pkg_postrm() {
	python_version
	# Careful not to remove this on up/downgrades.
	local sitep="${ROOT}"usr/$(get_libdir)/python${PYVER}/site-packages
	if [[ -e "${sitep}/pkgcore/plugins/plugincache2" ]] &&
		! [[ -e "${sitep}/pkgcore/plugin.py" ]]; then
		rm "${sitep}/pkgcore/plugins/plugincache2"
	fi
	distutils_pkg_postrm
}

src_test() {
	"${python}" setup.py test || die "testing returned non zero"
}
