# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/i2c/i2c-2.8.0.ebuild,v 1.1 2003/08/13 20:32:35 lostlogic Exp $

# plasmaroo@plasmaroo.squirrelserver.co.uk, datestamp Tue Aug 12, 11:11 PM

S=${WORKDIR}/${P}
DESCRIPTION="I2C Bus support for 2.4.x kernels"
SRC_URI="http://www2.lm-sensors.nu/~lm78/archive/${P}.tar.gz"
HOMEPAGE="http://www2.lm-sensors.nu/~lm78"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
LICENSE="GPL-2"
DEPEND=""

src_compile ()  {

	echo
	einfo "*****************************************************************"
	einfo
	einfo "This ebuild assumes your *current* kernel is >=2.4.9 && < 2.5+ "
	einfo 
        einfo "For 2.5+ series kernels, use the support already in the kernel"
        einfo "under 'Character devices' -> 'I2C support'."
	einfo
        einfo "To cross-compile, 'export LINUX=\"/lib/modules/<version>/build\"'"
        einfo "or symlink /usr/src/linux to another kernel."
	einfo
	einfo "*****************************************************************"
	echo

        if [ "$LINUX" != "" ]; then
                einfo "Cross-compiling using:- $LINUX"
                einfo "Using headers from:- `echo $LINUX/include/linux | sed 's/\/\//\//'`"
                LINUX=`echo $LINUX | sed 's/build\//build/'`
        else
                einfo "You are running:- `uname -r`"
                check_KV || die "Cannot find kernel in /usr/src/linux"
                einfo "Using kernel in /usr/src/linux/:- ${KV}"
                                                                                                                                           
                echo ${KV} | grep 2.4. > /dev/null
                if [ $? == 1 ]; then
                        eerror "Kernel version in /usr/src/linux is not 2.4.x"
                        eerror "Please specify a 2.4.x kernel!"
                        die "Incompatible Kernel"
                else
                        LINUX='/usr/src/linux'
                fi
                                                                                                                                           
                if [ "${KV}" != "`uname -r`" ]; then
                        ewarn "WARNING:- kernels do not match!"
                fi
        fi

	echo
	sleep 2

	emake LINUX=$LINUX clean all || \
	die "i2c requires the source of a compatible kernel version installed in /usr/src/linux or the environmental variable \$LINUX and kernel i2c *disabled* or *enabled as a module*"
}

src_install () {

	emake LINUX=$LINUX LINUX_INCLUDE_DIR=/usr/include/linux DESTDIR=${D} PREFIX=/usr MANDIR=/usr/share/man install || die
	dodoc CHANGES INSTALL README

}

pkg_postinst() {
	[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules

	echo
	einfo "*****************************************************************"
	einfo
	einfo "I2C modules installed ..."
	einfo
	einfo "IMPORTANT ... if you are installing this package you need to"
	einfo "IMPORTANT ... *disable* kernel I2C support OR *modularize it*"
	einfo "IMPORTANT ... if your 2.4.x kernel is patched with such support"
	einfo
	einfo "*****************************************************************"
	echo

}


