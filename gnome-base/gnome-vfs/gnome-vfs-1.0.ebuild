# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-vfs/gnome-vfs-1.0.ebuild,v 1.1 2001/04/13 16:59:03 pete Exp $

A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="gnome-vfs"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/unstable/sources/${PN}/${A}
         ftp://gnome.eazel.com/pub/gnome/unstable/sources/${PN}/${A}"
HOMEPAGE="http://www.gnome.org/"

DEPEND="nls? ( sys-devel/gettext )
	>=gnome-base/gnome-env-1.0
        >=gnome-base/gconf-1.0.0
        >=gnome-base/gnome-libs-1.2.13"


src_unpack() {
  unpack ${A}
  cd ${S}
  patch -p1 < ${FILESDIR}/${P}-gentoo-intl.diff
}

src_compile() {

  local myconf
  if [ -z "`use nls`" ]
  then
    myconf="--disable-nls"
  fi
  try ./configure --host=${CHOST} --prefix=/opt/gnome --sysconfdir=/etc/opt/gnome \
        --mandir=/opt/gnome/share/man ${myconf}
  try make

}

src_install() {

  try make prefix=${D}/opt/gnome sysconfdir=${D}/etc/opt/gnome mandir=${D}/opt/gnome/share/man install
  dodoc AUTHORS COPYING* ChangeLog NEWS README
}





