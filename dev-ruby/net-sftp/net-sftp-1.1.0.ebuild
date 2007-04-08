# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/net-sftp/net-sftp-1.1.0.ebuild,v 1.9 2007/04/08 12:20:42 corsair Exp $

inherit ruby gems

DESCRIPTION="SFTP in pure Ruby"
HOMEPAGE="http://net-ssh.rubyforge.org/"
SRC_URI="http://gems.rubyforge.org/gems/${P}.gem"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ia64 ppc ppc64 x86"
IUSE=""

USE_RUBY="ruby18"

RDEPEND="dev-ruby/net-ssh"

