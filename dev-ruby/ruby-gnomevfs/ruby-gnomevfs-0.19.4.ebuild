# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-gnomevfs/ruby-gnomevfs-0.19.4.ebuild,v 1.6 2012/05/01 18:24:23 armin76 Exp $

EAPI="2"
USE_RUBY="ruby18"

inherit ruby-ng-gnome2

DESCRIPTION="Ruby GnomeVFS bindings"
KEYWORDS="alpha amd64 ppc x86"
IUSE=""

RDEPEND="${RDEPEND}
	>=gnome-base/gnome-vfs-2.2"
DEPEND="${DEPEND}
	>=gnome-base/gnome-vfs-2.2
	dev-util/pkgconfig"

each_ruby_test() {
	cd tests
	ruby -I../src/lib -I../src test1.rb || die "test1.rb failed"
	ruby -I../src/lib -I../src test2.rb || die "test2.rb failed"
	ruby -I../src/lib -I../src test3.rb || die "test3.rb failed"
}
