# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/fastthread/fastthread-1.0.7.ebuild,v 1.2 2009/09/05 19:02:03 ranger Exp $

inherit ruby gems

USE_RUBY="ruby18"
DESCRIPTION="Optimized replacement for thread.rb primitives"
# Mongrel hosts gem_plugin, so setting that as homepage
HOMEPAGE="http://mongrel.rubyforge.org/"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
