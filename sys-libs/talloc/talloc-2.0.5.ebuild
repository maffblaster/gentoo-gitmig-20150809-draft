# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/talloc/talloc-2.0.5.ebuild,v 1.2 2011/03/01 23:03:58 abcd Exp $

EAPI=3

inherit waf-utils

DESCRIPTION="Samba talloc library"
HOMEPAGE="http://talloc.samba.org/"
SRC_URI="http://samba.org/ftp/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux"
IUSE="compat python"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-libs/libxslt"

WAF_BINARY="${S}/buildtools/bin/waf"

src_configure() {
	local extra_opts=""

	use compat && extra_opts+=" --enable-talloc-compat1"
	use python || extra_opts+=" --disable-python"
	waf-utils_src_configure \
		${extra_opts}
}
