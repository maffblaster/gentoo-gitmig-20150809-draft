# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/pdf-reader/pdf-reader-0.10.0.ebuild,v 1.2 2012/02/06 17:28:02 ranger Exp $

EAPI=2

GITHUB_USER=yob

USE_RUBY="ruby18 ruby19 ree18 jruby"

RUBY_FAKEGEM_TASK_TEST="spec"

RUBY_FAKEGEM_TASK_DOC="doc"
RUBY_FAKEGEM_DOCDIR="doc"
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README.rdoc TODO"

inherit ruby-fakegem

DESCRIPTION="PDF parser conforming as much as possible to the PDF specification from Adobe"
HOMEPAGE="http://github.com/yob/pdf-reader/"

# We cannot use the gem distributions because they don't contain the
# tests' data, we have to rely on the git tags.
SRC_URI="http://github.com/${GITHUB_USER}/${PN}/tarball/v${PV} -> ${PN}-git-${PV}.tgz"
S="${WORKDIR}/${GITHUB_USER}-${PN}-*"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~ppc"
IUSE=""

ruby_add_rdepend dev-ruby/ascii85

# rspec is loaded even during doc generation, so keep it around :(
ruby_add_bdepend ">=dev-ruby/rspec-2.1:2"

all_ruby_prepare() {
	# Remove bundler support
	sed -i -e '/[Bb]undler/d' Rakefile spec/spec_helper.rb || die
	rm Gemfile || die

	# Roodi is not yet available in CVS.
	sed -i -e '/roodi/d' Rakefile || die
}

all_ruby_install() {
	all_fakegem_install

	docinto examples
	dodoc examples/* || die
}
