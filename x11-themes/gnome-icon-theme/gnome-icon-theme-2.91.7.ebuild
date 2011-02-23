# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gnome-icon-theme/gnome-icon-theme-2.91.7.ebuild,v 1.3 2011/02/23 23:14:45 hwoarang Exp $

EAPI="3"
GCONF_DEBUG="no"

inherit gnome2 eutils autotools

DESCRIPTION="GNOME default icon themes"
HOMEPAGE="http://www.gnome.org/ http://people.freedesktop.org/~jimmac/icons/#git"

SRC_URI="${SRC_URI}
	branding? ( http://www.mail-archive.com/tango-artists@lists.freedesktop.org/msg00043/tango-gentoo-v1.1.tar.gz )"

LICENSE="LGPL-3 CCPL-Attribution-ShareAlike-3.0
	branding? ( CCPL-Sampling-Plus-1.0 )"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="branding"

RDEPEND=">=x11-themes/hicolor-icon-theme-0.10"
DEPEND="${RDEPEND}
	>=x11-misc/icon-naming-utils-0.8.7
	>=dev-util/pkgconfig-0.19
	>=dev-util/intltool-0.40
	sys-devel/gettext"

# This ebuild does not install any binaries
RESTRICT="binchecks strip"

# FIXME: double check potential LINGUAS problem
pkg_setup() {
	DOCS="AUTHORS NEWS TODO"
	G2CONF="${G2CONF} --enable-icon-mapping"
}

src_prepare() {
	gnome2_src_prepare

	if use branding; then
		for i in 16 22 24 32 48; do
			cp "${WORKDIR}"/tango-gentoo-v1.1/${i}x${i}/gentoo.png \
			"${S}"/gnome//${i}x${i}/places/start-here.png \
			|| die "Copying gentoo logos failed"
		done
	fi

	# Revert upstream commit that is wrongly updating icon cache, upstream bug #642449
	EPATCH_OPTS="-R" epatch "${FILESDIR}/${PN}-2.91.7-update-cache.patch"
	intltoolize --force --copy --automake || die "intltoolize failed"
	eautoreconf
}
