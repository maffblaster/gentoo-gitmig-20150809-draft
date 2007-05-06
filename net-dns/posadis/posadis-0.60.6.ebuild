# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/posadis/posadis-0.60.6.ebuild,v 1.8 2007/05/06 09:20:05 genone Exp $

inherit libtool eutils multilib autotools

DESCRIPTION="An authoritative/caching Domain Name Server"
HOMEPAGE="http://www.posadis.org/posadis"
SRC_URI="mirror://sourceforge/posadis/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="fam"

RDEPEND=">=dev-cpp/poslib-1.0.6
	fam? ( virtual/fam )"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.58"

src_unpack() {
	unpack ${A}
	
	#fix makefile problem
	cd ${S}/libltdl
	WANT_AUTOCONF="2.5" autoconf || die "libltdl autoconf failed"

	cd ../
	find . -name 'Makefile.am' -or -name 'configure.in' | xargs sed -i -e "s:/lib/:/$(get_libdir)/:g"

	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	econf `use_enable fam` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	# make directory for posadis pidfile and zone data files
	keepdir /var/posadis
	keepdir /etc/posadis

	newinitd ${FILESDIR}/${PN}-init posadis
	insinto /etc/
	doins posadisrc

	dodoc AUTHORS ChangeLog INSTALL README TODO
}

pkg_preinst() {
	source /etc/init.d/functions.sh
	if [ -L ${svcdir}/started/posadis ]; then
		ewarn "The posadis init script is running. I'll stop it, merge the new files and restart the script."
		/etc/init.d/posadis stop
	fi
}
