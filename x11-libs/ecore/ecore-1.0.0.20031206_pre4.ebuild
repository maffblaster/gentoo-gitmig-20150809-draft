# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/ecore/ecore-1.0.0.20031206_pre4.ebuild,v 1.1 2003/12/07 08:40:20 vapier Exp $

inherit enlightenment flag-o-matic

DESCRIPTION="core event abstraction layer and X abstraction layer (nice convenience library)"
HOMEPAGE="http://www.enlightenment.org/pages/ecore.html"

IUSE="${IUSE} opengl fbcon X"

DEPEND="${DEPEND}
	>=x11-libs/evas-1.0.0.20031013_pre12
	virtual/x11
	opengl? ( virtual/opengl )"

src_compile() {
	use alpha && append-flags -fPIC
	# X and fb have to be enabled otherwise it fails right now ;)
	export MY_ECONF="
		`use_enable X ecore-x` \
		--enable-ecore-job \
		`use_enable fbcon enable-ecore-fb` \
		--enable-ecore-evas \
		`use_enable opengl ecore-evas-gl` \
		--enable-ecore-con \
		--enable-ecore-ipc \
		--enable-ecore-txt
	"
	enlightenment_src_compile
}
