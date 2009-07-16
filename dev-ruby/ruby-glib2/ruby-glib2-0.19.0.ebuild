# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/ruby-glib2/ruby-glib2-0.19.0.ebuild,v 1.1 2009/07/16 07:05:21 graaff Exp $

inherit ruby ruby-gnome2 eutils

DESCRIPTION="Ruby Glib2 bindings"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
USE_RUBY="ruby18"
RDEPEND=">=dev-libs/glib-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
