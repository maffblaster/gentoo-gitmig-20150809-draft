# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-php/phpdbg/phpdbg-2.15.5-r1.ebuild,v 1.1 2011/12/14 22:52:52 mabi Exp $

EAPI=3

PHP_EXT_NAME="dbg"
PHP_EXT_INI="yes"
PHP_EXT_ZENDEXT="no"

USE_PHP="php5-2"

inherit php-ext-source-r2

KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

DESCRIPTION="A PHP debugger useable with some editors like phpedit."
HOMEPAGE="http://dd.cron.ru/dbg/"
SRC_URI="mirror://sourceforge/dbg2/dbg-${PV}.tar.gz"
LICENSE="dbgphp"
SLOT="0"
IUSE=""

DEPEND="<dev-lang/php-5.3[-threads]"
RDEPEND="${DEPEND}"

S="${WORKDIR}/dbg-${PV}"

my_conf="--enable-dbg=shared --with-dbg-profiler"

src_install() {
	php-ext-source-r2_src_install
	dodoc-php AUTHORS COPYING INSTALL

	php-ext-source-r2_addtoinifiles "[Debugger]"
	php-ext-source-r2_addtoinifiles "debugger.enabled" "on"
	php-ext-source-r2_addtoinifiles "debugger.profiler_enabled" "on"
}
