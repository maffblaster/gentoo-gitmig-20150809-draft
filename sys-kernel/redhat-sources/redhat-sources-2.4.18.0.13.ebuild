# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Maintainer: Bruce A. Locke <blocke@shivan.org>
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/redhat-sources/redhat-sources-2.4.18.0.13.ebuild,v 1.3 2002/04/28 07:42:59 blocke Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

#we use this next variable to avoid duplicating stuff on cvs
GFILESDIR=${PORTDIR}/sys-kernel/linux-sources/files
OKV=2.4.18
KV=2.4.19-0.13-redhat
S=${WORKDIR}/linux-${KV}
ETYPE="sources"

# INCLUDED:
# Redhat Skipjack Beta 2 Kernel

DESCRIPTION="Full sources for the Redhat Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2  http://www.ibiblio.org/gentoo/distfiles/linux-${KV}.patch.bz2"
PROVIDE="virtual/linux-sources"
HOMEPAGE="http://www.kernel.org/ http://www.redhat.com/" 

if [ $ETYPE = "sources" ] && [ -z "`use build`" ]
then
	#console-tools is needed to solve the loadkeys fiasco; binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND=">=sys-devel/binutils-2.11.90.0.31"
	RDEPEND=">=sys-libs/ncurses-5.2 sys-devel/perl >=sys-apps/modutils-2.4.2 sys-devel/make"
fi

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2
	mv linux linux-${KV} || die
	cd ${S}
	cat ${DISTDIR}/linux-${KV}.patch.bz2 | bzip2 -d | patch -p1 || die
	
	#sometimes we have icky kernel symbols; this seems to get rid of them
	make mrproper || die

	#this file is required for other things to build properly, so we autogenerate it
	#make include/linux/version.h || die

	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0.0 *
	chmod -R a+r-w+X,u+w *

	# Gentoo Linux uses /boot, so fix 'make install' to work properly
	cd ${S}
	mv Makefile Makefile.orig
	sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
		Makefile.orig >Makefile || die # test, remove me if Makefile ok
	rm Makefile.orig
}

src_compile() {
	if [ "$ETYPE" = "headers" ]
	then
		yes "" | make oldconfig		
		echo "Ignore any errors from the yes command above."
	fi
}

src_install() {
	if [ "$ETYPE" = "sources" ]
	then
		dodir /usr/src
		echo ">>> Copying sources..."
		mv ${WORKDIR}/* ${D}/usr/src
	else
		#linux-headers
		dodir /usr/include/linux
		cp -ax ${S}/include/linux/* ${D}/usr/include/linux
		rm -rf ${D}/usr/include/linux/modules
		dodir /usr/include/asm
		cp -ax ${S}/include/asm-i386/* ${D}/usr/include/asm
	fi
}

pkg_preinst() {
	if [ "$ETYPE" = "headers" ] 
	then
		[ -L ${ROOT}usr/include/linux ] && rm ${ROOT}usr/include/linux
		[ -L ${ROOT}usr/include/asm ] && rm ${ROOT}usr/include/asm
		true
	fi
}

pkg_postinst() {
	[ "$ETYPE" = "headers" ] && return
	cd ${ROOT}usr/src/linux-${KV}
	make mrproper
	if [ -e "${ROOT}usr/src/linux/.config" ]
	then
		cp "${ROOT}usr/src/linux/.config" .config
		#we only make dep when upgrading to a new kernel (with existing config)
		#The default setting will be selected.
		yes "" | make oldconfig
		echo "Ignore any errors from the yes command above."
		make dep
	else
		cp "${ROOT}usr/src/linux-${KV}/arch/i386/defconfig" .config
	fi
	#remove /usr/src/linux symlink
	rm -f ${ROOT}/usr/src/linux
	#set up a new one
	ln -sf linux-${KV} ${ROOT}/usr/src/linux
}
