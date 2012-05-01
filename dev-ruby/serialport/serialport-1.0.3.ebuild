# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/serialport/serialport-1.0.3.ebuild,v 1.2 2012/05/01 18:24:16 armin76 Exp $

EAPI="2"

# jruby → uses native library
USE_RUBY="ruby18"

RUBY_FAKEGEM_TASK_DOC=""
RUBY_FAKEGEM_TASK_TEST=""
RUBY_FAKEGEM_EXTRADOC="CHANGELOG README"

inherit ruby-fakegem

DESCRIPTION="a library for serial port (rs232) access in ruby"
HOMEPAGE="http://rubyforge.org/projects/ruby-serialport/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc x86"
IUSE=""

all_ruby_prepare() {
	# Fix the miniterm script so that it might actually work, we'll
	# install it as example.
	sed -i -e 's:\.\./serialport.so:serialport:' test/miniterm.rb || die
}

each_ruby_configure() {
	cd ext/native
	${RUBY} extconf.rb || die
}

each_ruby_compile() {
	pushd ext/native &>/dev/null
	emake || die
	popd &>/dev/null

	# Avoids the need for a specific install phase
	cp ext/native/*.so lib/ || die "extension copy failed"
}

all_ruby_install() {
	all_fakegem_install

	# don't compress it
	insinto /usr/share/doc/${PF}/examples
	doins test/miniterm.rb || die
}
