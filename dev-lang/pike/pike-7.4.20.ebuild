# Copyright 1999-2003 Gentoo Technologies, Inc., Emil Sk�ldberg (see ChangeLog)
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pike/pike-7.4.20.ebuild,v 1.10 2003/09/16 16:30:10 scandium Exp $

inherit flag-o-matic

# -fomit-frame-pointer breaks the compilation
filter-flags -fomit-frame-pointer

IUSE="debug doc gdbm mysql zlib"

S="${WORKDIR}/Pike-v${PV}"
HOMEPAGE="http://pike.ida.liu.se/"
DESCRIPTION="Pike programming language and runtime"
SRC_URI="ftp://pike.ida.liu.se/pub/pike/all/${PV}/Pike-v${PV}.tar.gz"

LICENSE="GPL-2 | LGPL-2.1 | MPL-1.1"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-libs/gmp
	sys-devel/gcc
	sys-devel/make
	sys-apps/sed
	sys-devel/bc"

src_compile() {
	local myconf
	use zlib  || myconf="${myconf} --without-zlib"
	use mysql || myconf="${myconf} --without-mysql"
	use debug || myconf="${myconf} --without-debug"
	use gdbm  || myconf="${myconf} --without-gdbm"

	# We have to use --disable-make_conf to override make.conf settings
	# Otherwise it may set -fomit-frame-pointer again
	# disable ffmpeg support because it does not compile
	emake CONFIGUREARGS="${myconf} --prefix=/usr --disable-make_conf --without-ffmpeg" || die

	cd ${S}/refdoc
	PATH="${S}/bin:${PATH}" make || die
}

src_install() {
	# the installer should be stopped from removing files
	sed -i s/rm\(mod\+\"\.o\"\)\;/\{\}/ ${S}/bin/install.pike || die "Failed to modify install.pike"
	make INSTALLARGS="--traditional" buildroot="${D}" install || die

	if use doc; then
		einfo "Installing 60MB of docs, this could take some time ..."
		dohtml -r ${S}/refdoc/traditional_manual ${S}/refdoc/modref
	fi
}
