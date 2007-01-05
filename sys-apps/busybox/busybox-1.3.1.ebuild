# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/busybox/busybox-1.3.1.ebuild,v 1.6 2007/01/05 08:23:55 vapier Exp $

inherit eutils flag-o-matic

################################################################################
# BUSYBOX ALTERNATE CONFIG MINI-HOWTO
#
# Busybox can be modified in many different ways. Here's a few ways to do it:
#
# (1) Emerge busybox with FEATURES=keepwork so the work directory won't
#     get erased afterwards. Add a definition like ROOT=/my/root/path to the
#     start of the line if you're installing to somewhere else than the root
#     directory. This command will save the default configuration to
#     ${PORTAGE_CONFIGROOT} (or ${ROOT} if ${PORTAGE_CONFIGROOT} is not 
#     defined), and it will tell you that it has done this. Note the location
#     where the config file was saved.
#
#     FEATURES=keepwork USE=savedconfig emerge busybox
#
# (2) Go to the work directory and change the configuration of busybox using its
#     menuconfig feature.
#
#     cd /var/tmp/portage/busybox*/work
#     make menuconfig
#
#
# (3) Save your configuration to the default location and copy it to the
#     savedconfig location as follows. Replace X.X.X by the version of 
#     busybox, and change the path if you're overriding ${ROOT} or
#     ${PORTAGE_CONFIGROOT}. The file should overwrite the default config
#     file that was written by the ebuild during step 1.
#
#     cp .config /etc/portage/savedconfig/busybox-X.X.X.config
#
# (4) Execute the same command as in step 1 to build the new busybox config;
#     the FEATURES=keepwork option is probably no longer necessary unless you
#     want to modify the configuration further.
#
################################################################################
#
# (1) Alternatively skip the above steps and simply emerge busybox with 
#     USE=savedconfig and edit the file it saves by hand. Then remerge bb as 
#     needed.
#
################################################################################


#SNAPSHOT=20040726
SNAPSHOT=""

DESCRIPTION="Utilities for rescue and embedded systems"
HOMEPAGE="http://www.busybox.net/"
if [[ -n ${SNAPSHOT} ]] ; then
	MY_P=${PN}
	SRC_URI="http://www.busybox.net/downloads/snapshots/${PN}-${SNAPSHOT}.tar.bz2"
else
	MY_P=${PN}-${PV/_/-}
	SRC_URI="http://www.busybox.net/downloads/${MY_P}.tar.bz2
		http://busybox.net/downloads/fixes-1.3.1/busybox-1.3.1.shadow.patch"
fi

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="debug static savedconfig make-symlinks"
RESTRICT="test"

DEPEND=""

S=${WORKDIR}/${MY_P}

# <pebenito> then eventually turning on selinux would mean
# adding a dep: selinux? ( sys-libs/libselinux )

pkg_setup() {
	# Catch most people for now #159497 ... delete this check
	# once we move to stable for releases
	if [[ $(LC_ALL="C" date +%Z) == "Local time zone must be set--see zic manual page" ]] ; then
		eerror "You forgot to set up your /etc/localtime."
		eerror "You should do so now."
		die "forgetful admin detected"
	fi
}

busybox_config_option() {
	case $1 in
		y) sed -i -e "s:.*CONFIG_$2.*set:CONFIG_$2=y:g" .config;;
		n) sed -i -e "s:CONFIG_$2=y:# CONFIG_$2 is not set:g" .config;;
		*) use $1 \
		       && busybox_config_option y $2 \
		       || busybox_config_option n $2
		   return 0
		   ;;
	esac
	einfo $(grep "CONFIG_$2[= ]" .config)
}

src_unpack() {
	unset KBUILD_OUTPUT #88088

	unpack ${A}
	cd "${S}"

	# patches go here!
	epatch "${FILESDIR}"/1.3.0/bb.patch
	epatch "${FILESDIR}"/1.3.0/ld.patch
	epatch "${DISTDIR}"/${P}.shadow.patch

	# work around broken ass powerpc compilers
	use ppc64 && append-flags -mminimal-toc
	# flag cleanup
	sed -i \
		-e 's: -Werror : :' \
		-e 's:-Os -falign-functions=1 -falign-jumps=1 -falign-loops=1::' \
		-e 's:-fomit-frame-pointer::' \
		Makefile.flags
	sed -i "/^CFLAGS.*:=/s:$: ${CFLAGS}:" Makefile
	echo "CROSS_COMPILE := ${CHOST}-" >> Makefile.flags

	# check for a busybox config before making one of our own.
	# if one exist lets return and use it.
	# fine grained config control for user defined busybox configs.
	# [package]-[version]-[revision].config
	# [package]-[version].config
	# [package].config

	if use savedconfig ; then
		local conf root
		[[ -r .config ]] && rm .config
		for conf in {${PF},${P},${PN}}{,-${CHOST}} ; do
			for root in "${PORTAGE_CONFIGROOT}" "${ROOT}" / ; do
				configfile=${root}etc/portage/savedconfig/${conf}.config
				if [[ -r ${configfile} ]] ; then
					einfo "Found your ${configfile} and using it."
					cp ${configfile} "${S}"/.config
					yes "" | make oldconfig > /dev/null
					return 0
				fi
			done
		done
		ewarn "Could not locate user configfile, so we will save a default one"
	fi

	# setup the config file
	make allyesconfig > /dev/null
	busybox_config_option n DMALLOC
	busybox_config_option n FEATURE_SUID_CONFIG
	busybox_config_option n BUILD_AT_ONCE
	busybox_config_option n BUILD_LIBBUSYBOX

	# If these are not set and we are using a uclibc/busybox setup
	# all calls to system() will fail.
	busybox_config_option y FEATURE_SH_IS_ASH
	busybox_config_option n FEATURE_SH_IS_NONE

	busybox_config_option static STATIC
	busybox_config_option debug DEBUG
	use debug \
		&& busybox_config_option y NO_DEBUG_LIB \
		&& busybox_config_option n DMALLOC \
		&& busybox_config_option n EFENCE

	busybox_config_option selinux SELINUX

	# default a bunch of uncommon options to off
	for opt in LOCALE_SUPPORT TFTP FTP{GET,PUT} IPCALC TFTP HUSH \
		LASH MSH INETD DPKG RPM2CPIO RPM FOLD LOGNAME OD CRONTAB \
		UUDECODE UUENCODE SULOGIN DC DEBUG_YANK_SUSv2 DEBUG_INIT \
		DEBUG_CROND_OPTION FEATURE_UDHCP_DEBUG
	do
		busybox_config_option n ${opt}
	done

	make oldconfig > /dev/null
}

src_compile() {
	unset KBUILD_OUTPUT #88088

	emake busybox || die "build failed"
	if ! use static ; then
		mv busybox_unstripped{,.bak}
		LDFLAGS="${LDFLAGS} -static" emake busybox || die "static build failed"
		mv busybox_unstripped bb
		mv busybox_unstripped{.bak,}
	fi
}

src_install() {
	unset KBUILD_OUTPUT #88088

	into /
	newbin busybox_unstripped busybox || die
	use static \
		&& dosym busybox /bin/bb \
		|| dobin bb
	dosym bb /bin/busybox.static

	# bundle up the symlink files for use later
	emake install || die
	rm _install/bin/busybox
	tar cf busybox-links.tar -C _install . || die
	insinto /usr/share/${PN}
	doins busybox-links.tar || die
	newins .config ${PF}.config || die

	dodoc AUTHORS README TODO

	cd docs || die
	docinto txt
	dodoc *.txt
	docinto pod
	dodoc *.pod
	dohtml *.html *.sgml

	cd ../examples || die
	docinto examples
	dodoc inittab depmod.pl *.conf *.script undeb unrpm

	cd bootfloppy || die
	docinto bootfloppy
	dodoc * etc/* etc/init.d/* 2>/dev/null
}

pkg_preinst() {
	if use make-symlinks && [[ ! ${VERY_BRAVE_OR_VERY_DUMB} == "yes" ]] && [[ ${ROOT} == "/" ]] ; then
		ewarn "setting USE=make-symlinks and emerging to / is very dangerous."
		ewarn "it WILL overwrite lots of system programs like: ls bash awk grep (bug 60805 for full list)."
		ewarn "If you are creating a binary only and not merging this is probably ok."
		ewarn "set env VERY_BRAVE_OR_VERY_DUMB=yes if this is realy what you want."
		die "silly options will destroy your system"
	fi

	if use make-symlinks ; then
		mv "${D}"/usr/share/${PN}/busybox-links.tar "${T}"/ || die
	fi
	if use savedconfig ; then
		mv "${D}"/usr/share/${PN}/${PF}.config "${T}"/ || die
	fi
}

pkg_postinst() {
	if use make-symlinks ; then
		cd "${T}" || die
		mkdir _install
		tar xf busybox-links.tar -C _install || die
		cp -vpPR _install/* "${ROOT}"/ || die "copying links for ${x} failed"
	fi

	if use savedconfig ; then
		local config_dir="${PORTAGE_CONFIGROOT:-${ROOT}}/etc/portage/savedconfig"
		einfo "Saving this build config to ${config_dir}/${PF}.config"
		einfo "Read this ebuild for more info on how to take advantage of this option"
		mkdir -p "${config_dir}"
		cp "${T}"/${PF}.config "${config_dir}"/${PF}.config
		return 0
	fi
	echo
	einfo "This ebuild has support for user defined configs"
	einfo "Please read this ebuild for more details and re-emerge as needed"
	einfo "if you want to add or remove functionality for ${PN}"
	echo
}
