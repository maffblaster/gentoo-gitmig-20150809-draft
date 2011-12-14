# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/pecl-mailparse/pecl-mailparse-2.1.5-r1.ebuild,v 1.1 2011/12/14 22:41:18 mabi Exp $

EAPI=3

PHP_EXT_NAME="mailparse"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"
DOCS="README"

inherit php-ext-pecl-r2

KEYWORDS="amd64 ~ppc ~ppc64 x86"

DESCRIPTION="A PHP extension for parsing and working with RFC822 and RFC2045 (MIME) compliant messages."
LICENSE="PHP-2.02"
SLOT="0"
IUSE=""

RDEPEND="dev-lang/php[unicode]"
DEPEND="${RDEPEND}
	dev-util/re2c"
