# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/PECL-imagick/PECL-imagick-0.9.11.ebuild,v 1.4 2006/01/19 11:39:15 chtekk Exp $

PHP_EXT_ZENDEXT="no"
PHP_EXT_INI="yes"

inherit php-ext-pecl

IUSE="graphicsmagick"
DESCRIPTION="PHP wrapper for the ImageMagick library."
HOMEPAGE="http://pecl.php.net/imagick"
SLOT="0"
LICENSE="PHP"
KEYWORDS="~x86"

DEPEND="${DEPEND}
		!graphicsmagick? ( >=media-gfx/imagemagick-6.2.0 )
		graphicsmagick? ( >=media-gfx/graphicsmagick-1.0.0 )"

src_compile () {
	myconf="--with-imagick"
	use graphicsmagick && myconf="${myconf} --with-imagick-gm"
	php-ext-pecl_src_compile
}

src_install() {
	php-ext-pecl_src_install
	dodoc CREDITS INSTALL
}
