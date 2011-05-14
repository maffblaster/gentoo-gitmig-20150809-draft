# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_mount/pam_mount-2.10.ebuild,v 1.2 2011/05/14 20:27:42 mattst88 Exp $

EAPI=4

inherit multilib

DESCRIPTION="A PAM module that can mount volumes for a user session"
HOMEPAGE="http://pam-mount.sourceforge.net"
SRC_URI="mirror://sourceforge/pam-mount/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="crypt ssl selinux"

COMMON_DEPEND=">=sys-libs/pam-0.99
	>=sys-libs/libhx-3.10.1
	dev-libs/libxml2
	crypt? ( >=sys-fs/cryptsetup-1.1.0 )
	ssl? ( dev-libs/openssl )
	selinux? ( sys-libs/libselinux )"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	app-arch/xz-utils"
RDEPEND="${COMMON_DEPEND}
	sys-process/lsof"

src_configure() {
	econf --with-slibdir="/$(get_libdir)" \
			$(use_with crypt cryptsetup) \
			$(use_with ssl crypto) \
			$(use_with selinux)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc doc/*.txt
}
