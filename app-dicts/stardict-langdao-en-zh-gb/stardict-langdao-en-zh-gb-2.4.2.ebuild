# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/stardict-langdao-en-zh-gb/stardict-langdao-en-zh-gb-2.4.2.ebuild,v 1.1 2004/08/25 12:59:29 citizen428 Exp $

FROM_LANG="English"
TO_LANG="Simplified Chinese (GB)"
DICT_PREFIX="langdao-ec-"
DICT_SUFFIX="gb"

inherit stardict

HOMEPAGE="http://stardict.sourceforge.net/Dictionaries_zh_CN.php"

KEYWORDS="~x86"
IUSE=""

RDEPEND=">=app-dicts/stardict-2.4.2"
