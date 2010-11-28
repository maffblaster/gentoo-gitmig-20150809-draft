# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/arel/arel-2.0.4.ebuild,v 1.1 2010/11/28 09:53:52 graaff Exp $

EAPI="2"
USE_RUBY="ruby18 ree18 jruby"

RUBY_FAKEGEM_TASK_DOC="docs"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="History.txt README.markdown"

inherit ruby-fakegem

DESCRIPTION="Arel is a Relational Algebra for Ruby."
HOMEPAGE="http://github.com/rails/arel"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

ruby_add_bdepend "
	doc? ( >=dev-ruby/hoe-2.6.2 )
	test? (
		>=dev-ruby/hoe-2.6.2
		virtual/ruby-minitest
	)"
