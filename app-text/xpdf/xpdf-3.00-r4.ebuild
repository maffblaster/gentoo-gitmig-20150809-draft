# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xpdf/xpdf-3.00-r4.ebuild,v 1.2 2004/10/24 13:49:48 lanius Exp $

inherit eutils

DESCRIPTION="An X Viewer for PDF Files"
HOMEPAGE="http://www.foolabs.com/xpdf/"
SRC_URI="ftp://ftp.foolabs.com/pub/xpdf/${P}.tar.gz
	linguas_ar? ( ftp://ftp.foolabs.com/pub/xpdf/xpdf-arabic.tar.gz )
	linguas_zh_CN? ( ftp://ftp.foolabs.com/pub/xpdf/xpdf-chinese-simplified.tar.gz )
	linguas_zh_TW? ( ftp://ftp.foolabs.com/pub/xpdf/xpdf-chinese-traditional.tar.gz )
	linguas_ru? ( ftp://ftp.foolabs.com/pub/xpdf/xpdf-cyrillic.tar.gz )
	linguas_el? ( ftp://ftp.foolabs.com/pub/xpdf/xpdf-greek.tar.gz )
	linguas_he? ( ftp://ftp.foolabs.com/pub/xpdf/xpdf-hebrew.tar.gz )
	linguas_ja? ( ftp://ftp.foolabs.com/pub/xpdf/xpdf-japanese.tar.gz )
	linguas_ko? ( ftp://ftp.foolabs.com/pub/xpdf/xpdf-korean.tar.gz )
	linguas_la? ( ftp://ftp.foolabs.com/pub/xpdf/xpdf-latin2.tar.gz )
	linguas_th? ( ftp://ftp.foolabs.com/pub/xpdf/xpdf-thai.tar.gz )
	linguas_tr? ( ftp://ftp.foolabs.com/pub/xpdf/xpdf-turkish.tar.gz )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64 ~ppc64"

DEPEND="motif? ( virtual/x11
	x11-libs/openmotif )
	>=media-libs/freetype-2.0.5
	>=media-libs/t1lib-1.3
	virtual/ghostscript"

RDEPEND="${DEPEND}
	linguas_ja? ( media-fonts/kochi-substitute )
	linguas_zh_CN? ( media-fonts/arphicfonts )
	linguas_zh_TW? ( media-fonts/arphicfonts )
	linguas_ko? ( media-fonts/baekmuk-fonts )
	!app-text/xpdf-chinese-simplified
	!app-text/xpdf-chinese-traditional
	!app-text/xpdf-cyrillic
	!app-text/xpdf-greek
	!app-text/xpdf-japanese
	!app-text/xpdf-korean
	!app-text/xpdf-latin2
	!app-text/xpdf-thai
	!app-text/xpdf-turkish"

IUSE="motif nodrm"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/xpdf-3.00-truetype.diff.gz
	epatch ${FILESDIR}/xpdf-3.00-freetype-2.1.7.patch
	epatch ${FILESDIR}/xpdf-3.00-empty-bookmark.patch
	epatch ${FILESDIR}/xpdf-3.00-core.patch.bz2
	epatch ${FILESDIR}/xpdf-3.00-overflow.patch.bz2
	epatch ${FILESDIR}/xpdf-3.00-PathScanner.patch.bz2
	use nodrm && epatch ${FILESDIR}/xpdf-3.00-nodrm.diff
	autoconf
}

src_compile() {
	econf \
		--enable-freetype2 \
		--with-freetype2-includes=/usr/include/freetype2 || die

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	prepallman
	dodoc README ANNOUNCE CHANGES
	insinto /etc
	newins ${FILESDIR}/xpdfrc.1 xpdfrc

	# install languages
	use linguas_ar && install_lang turkish
	use linguas_zh_CN && install_lang chinese-simplified
	use linguas_zh_TW && install_lang chinese-traditional
	use linguas_ru && install_lang cyrillic
	use linguas_el && install_lang greek
	use linguas_he && install_lang hebrew
	use linguas_ja && install_lang japanese
	use linguas_ko && install_lang korean
	use linguas_la && install_lang latin2
	use linguas_th && install_lang thai
	use linguas_tr && install_lang turkish

}

install_lang() {
	cd ../xpdf-$1
	sed 's,/usr/local/share/xpdf/,/usr/share/xpdf/,g' add-to-xpdfrc >> ${D}/etc/xpdfrc
	insinto /usr/share/xpdf/$1
	doins *.unicodeMap
	doins *.cid*
	insinto /usr/share/xpdf/$1/CMap
	doins CMap/*
}
