# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/linux-headers/linux-headers-2.4.19.ebuild,v 1.9 2002/12/15 10:44:24 bjb Exp $
#OKV=original kernel version, KV=patched kernel version.  They can be the same.

#we use this next variable to avoid duplicating stuff on cvs
GFILESDIR=${PORTDIR}/sys-kernel/linux-sources/files
SPARCFILEDIR=${PORTDIR}/sys-kernel/sparc-sources/files
OKV=2.4.19
KV=2.4.19
S=${WORKDIR}/linux-${KV}

#These are *stock* 2.4.19 headers, for niceness.

DESCRIPTION="Full sources for the Gentoo Linux kernel"
SRC_URI="http://www.kernel.org/pub/linux/kernel/v2.4/linux-${OKV}.tar.bz2"
PROVIDE="virtual/kernel"
HOMEPAGE="http://www.kernel.org/ http://www.gentoo.org/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

KERNEL_ARCH=`echo $ARCH |\
  sed -e s/[i]*.86/i386/ -e s/sun4u// -e s/arm.*/arm/ -e s/sa110/arm/`
if [ -z "$KERNEL_ARCH" ]
then
	KERNEL_ARCH=`uname -m |\
     sed -e s/[i]*.86/i386/ -e s/sun4u// -e s/arm.*/arm/ -e s/sa110/arm/`
fi 

if [ $PN = "linux-sources" ] && [ -z "`use build`" ]
then
	#console-tools is needed to solve the loadkeys fiasco; binutils version needed to avoid Athlon/PIII/SSE assembler bugs.
	DEPEND=">=sys-devel/binutils-2.11.90.0.31"
	RDEPEND =">=sys-libs/ncurses-5.2 sys-devel/perl >=sys-apps/modutils-2.4.2 sys-devel/make ? sys-devel/egcs64-sparc"
fi

[ -z "$LINUX_HOSTCFLAGS" ] && LINUX_HOSTCFLAGS="-Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -I${S}/include"

src_unpack() {
	cd ${WORKDIR}
	unpack linux-${OKV}.tar.bz2
	#the main source dir for linux-2.4.19 (and higher?) has the version attached
	if [ $OKV != $KV ]; then
		mv linux-${OKV} linux-${KV} || die "moving kernel"
	fi
	cd ${S}
	
	#sometimes we have icky kernel symbols; this seems to get rid of them
	make mrproper || die "making proper"

	#this file is required for other things to build properly, so we autogenerate it
	make include/linux/version.h || die "making headers"

	#fix silly permissions in tarball
	cd ${WORKDIR}
	chown -R 0.0 *
	chmod -R a+r-w+X,u+w *

	# Gentoo Linux uses /boot, so fix 'make install' to work properly
	cd ${S}
	mv Makefile Makefile.orig
	sed -e 's:#export\tINSTALL_PATH:export\tINSTALL_PATH:' \
		Makefile.orig >Makefile || die "sed makefile" # test, remove me if Makefile ok
	rm Makefile.orig
}

src_compile() {
	if [ "$PN" = "linux-headers" ]
	then
		yes "" | make oldconfig		
		echo "Ignore any errors from the yes command above."
	fi
}

src_install() {
	if [ "$PN" = "linux-sources" ]
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
		if [ `expr $KERNEL_ARCH ":" "sparc"` -eq 5 ]
		then
			dodir /usr/include/asm-{sparc,}
			if [ "$KERNEL_ARCH" = "" ]
			then
				cp -ax ${S}/include/asm-/* ${D}/usr/include/asm-
				if [ ! -r ${D}/usr/include/asm-/asm_offsets.h ]
				then
					cp ${SPARCFILEDIR}/${OKV}/-asm_offsets.h \
						${D}/usr/include/asm-/asm_offsets.h
				fi
			fi

			cp -ax ${S}/include/asm-sparc/* ${D}/usr/include/asm-sparc
			if [ ! -r ${D}/usr/include/asm-sparc/asm_offsets.h ]
			then
				cp ${SPARCFILEDIR}/${OKV}/sparc-asm_offsets.h \
					${D}/usr/include/asm-sparc/asm_offsets.h
			fi
			${SPARCFILEDIR}/generate-asm-sparc ${D}/usr/include

		else
			cp  -ax ${S}/include/asm-${KERNEL_ARCH}/* ${D}/usr/include/asm
		fi
	fi
}

pkg_preinst() {
	if [ "$PN" = "linux-headers" ] 
	then
		[ -L ${ROOT}usr/include/linux ] && rm ${ROOT}usr/include/linux
		[  -L ${ROOT}usr/include/asm ] && rm ${ROOT}usr/include/asm
		[ -L ${ROOT}usr/include/asm-sparc ] && rm ${ROOT}usr/include/asm-sparc
		[ -L ${ROOT}usr/include/asm- ] && rm ${ROOT}usr/include/asm-
		[ -L ${ROOT}usr/include/asm-${KERNEL_ARCH} ] && rm ${ROOT}usr/include/asm-${KERNEL_ARCH}
		true
	fi
}

pkg_postinst() {
	[ "$PN" = "linux-headers" ] && return
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
		cp  "${ROOT}usr/src/linux-${KV}/arch/${KERNEL_ARCH}/defconfig" .config \
			|| cp  "${ROOT}usr/src/linux-${KV}/arch/i386/defconfig" .config
	fi
	#remove /usr/src/linux symlink
	rm -f ${ROOT}/usr/src/linux
	#set up a new one
	ln -sf linux-${KV} ${ROOT}/usr/src/linux
}
