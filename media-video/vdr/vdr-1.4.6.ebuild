# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/vdr/vdr-1.4.6.ebuild,v 1.13 2009/07/06 10:23:35 zzam Exp $

inherit eutils flag-o-matic multilib

IUSE="vanilla aio bigpatch jumpplay dolby-record-switch dvbplayer
	lnbsharing sourcecaps cmdsubmenu dxr3-audio-denoise
	child-protection yaepg setup-plugin submenu subtitles rotor noepg"

PATCHSET_V=1
PATCHSET_NAME=gentoo-${PN}-patchset-${PV}-${PATCHSET_V}

MY_P="${P%_p*}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Video Disk Recorder - turns a pc into a powerful set top box for DVB"
HOMEPAGE="http://www.cadsoft.de/vdr/"
SRC_URI="ftp://ftp.cadsoft.de/vdr/${MY_P}.tar.bz2
	mirror://gentoo/${PATCHSET_NAME}.tar.bz2"

KEYWORDS="~amd64 ~ppc x86"
SLOT="0"
LICENSE="GPL-2"

COMMON_DEPEND="media-libs/jpeg
	sys-libs/libcap"

DEPEND="${COMMON_DEPEND}
	media-tv/linuxtv-dvb-headers"

RDEPEND="${COMMON_DEPEND}
	dev-lang/perl
	|| ( >=media-tv/gentoo-vdr-scripts-0.4.2 media-tv/vdrplugin-rebuild )
	>=media-tv/gentoo-vdr-scripts-0.3.5"

# pull in vdr-setup to get the xml files, else menu will not work
PDEPEND="setup-plugin? ( >=media-plugins/vdr-setup-0.3.1-r1 )"

# Relevant Pathes for vdr on gentoo
DVB_DIR=/usr/include
VDR_INCLUDE_DIR=/usr/include/vdr
PLUGIN_LIB_DIR="/usr/$(get_libdir)/vdr/plugins"
CONF_DIR=/etc/vdr
CAP_FILE="${S}/capabilities.sh"
CAPS="# Capabilities of the vdr-executable for use by startscript etc."

add_cap() {
	local ARG
	for ARG; do
		CAPS="${CAPS}\n${ARG}=1"
	done
}

src_unpack() {
	unpack ${MY_P}.tar.bz2
	if [[ -n "${VDR_LOCAL_PATCHSET}" && -d "${VDR_LOCAL_PATCHSET}" ]]; then
		ewarn "Using local developer patchset."
		PATCHSET_DIR="${VDR_LOCAL_PATCHSET}"
	else
		unpack "${PATCHSET_NAME}".tar.bz2
		PATCHSET_DIR="${WORKDIR}/${PATCHSET_NAME}"

		# Fix logic bigpatch+noepg, Bug #193550
		sed -i "${PATCHSET_DIR}"/apply_patchset.sh \
			-e 's/use noepg/use noepg \&\& use !bigpatch/'
	fi

	cd "${S}"
	epatch "${FILESDIR}"/vdr-dvb-api-5-is-fine.diff

	ebegin "Changing pathes for gentoo"
	sed -e 's-$(DVBDIR)/include-$(DVBDIR)-' -i Makefile

	sed \
	  -e 's-ConfigDirectory = VideoDirectory;-ConfigDirectory = CONFIGDIR;-' \
	  -i vdr.c

	cat > Make.config <<-EOT
		#
		# Generated by ebuild ${PF}
		#
		DVBDIR		 = ${DVB_DIR}
		PLUGINLIBDIR = ${PLUGIN_LIB_DIR}
		CONFIGDIR	 = ${CONF_DIR}

		DEFINES		+= -DCONFIGDIR=\"\$(CONFIGDIR)\"
	EOT
	eend 0

	source "${PATCHSET_DIR}"/apply_patchset.sh
	apply_vdr_patchset "${PATCHSET_DIR}"

	if use !vanilla; then
		if use setup-plugin && use submenu; then
			ewarn "Did not apply submenu-patch, can not be used at the same time as setup-plugin-patch."
		fi
	fi

	# apply local patches defined by variable VDR_LOCAL_PATCHES_DIR
	if test -n "${VDR_LOCAL_PATCHES_DIR}"; then
		local dir_tmp_var
		local LOCALPATCHES_SUBDIR=${PV}
		for dir_tmp_var in allversions-fallback ${PV%_p*} ${PV} ; do
			if [[ -d ${VDR_LOCAL_PATCHES_DIR}/${dir_tmp_var} ]]; then
				LOCALPATCHES_SUBDIR="${dir_tmp_var}"
			fi
		done

		elog
		if [[ ${LOCALPATCHES_SUBDIR} == ${PV} ]]; then
			elog "Applying local patches"
		else
			elog "Applying local patches (Using subdirectory: ${LOCALPATCHES_SUBDIR})"
		fi

		for LOCALPATCH in ${VDR_LOCAL_PATCHES_DIR}/${LOCALPATCHES_SUBDIR}/*.{diff,patch}; do
			test -f "${LOCALPATCH}" && epatch "${LOCALPATCH}"
		done
	fi

	if [[ -n "${VDRSOURCE_DIR}" ]]; then
		cp -r "${S}" "${T}"/source-tree
	fi

	if ! use vanilla; then
		add_cap CAP_IRCTRL_RUNTIME_PARAM \
			CAP_VFAT_RUNTIME_PARAM \
			CAP_SHUTDOWN_SVDRP \
			CAP_CHUID

		echo -e ${CAPS} > "${CAP_FILE}"
	fi
}

src_install() {
	exeinto /usr/bin
	doexe vdr
	doexe svdrpsend.pl

	insinto "${VDR_INCLUDE_DIR}"
	doins *.h
	doins Make.config

	insinto "${VDR_INCLUDE_DIR}"/libsi
	doins libsi/*.h

	keepdir "${CONF_DIR}"/plugins
	keepdir "${CONF_DIR}"/themes

	insinto "${CONF_DIR}"
	doins *.conf channels.conf.*

	keepdir "${PLUGIN_LIB_DIR}"

	doman vdr.1 vdr.5

	dohtml *.html
	dodoc MANUAL INSTALL README* HISTORY*
	dodoc TODO-enAIO-rm CONTRIBUTORS

	insinto /usr/share/vdr
	doins "${CAP_FILE}"

	if [[ -n "${VDRSOURCE_DIR}" ]]; then
		elog "Installing sources"
		insinto "${VDRSOURCE_DIR}/${P}"
		doins -r "${T}"/source-tree/*
		keepdir "${VDRSOURCE_DIR}/${P}"/PLUGINS/lib
	fi

	if use setup-plugin; then
		insinto /usr/share/vdr/setup
		doins "${S}"/menu.c
	fi
	chown -R vdr:vdr "${D}/${CONF_DIR}"
}

pkg_preinst() {
	has_version "<${CATEGORY}/${PN}-1.3.36-r3"
	previous_less_than_1_3_36_r3=$?
}

pkg_postinst() {
	elog "It is a good idea to run vdrplugin-rebuild now"
	if [[ $previous_less_than_1_3_36_r3 = 0 ]] ; then
		ewarn "Upgrade Info:"
		ewarn
		ewarn "If you had used the use-flags lirc, rcu or vfat"
		ewarn "then, you now have to enable the associated functionality"
		ewarn "in /etc/conf.d/vdr"
		ewarn
		ewarn "vfat is now set with VFAT_FILENAMES."
		ewarn "lirc/rcu are now set with IR_CTRL."
		ebeep
	fi

	if use setup-plugin; then
		if ! has_version media-plugins/vdr-setup || \
			! egrep -q '^setup$' "${ROOT}/etc/conf.d/vdr.plugins"; then

			echo
			ewarn "You have compiled media-video/vdr with USE=\"setup-plugin\""
			ewarn "It is very important to emerge media-plugins/vdr-setup now!"
			ewarn "and you have to loaded it in /etc/conf.d/vdr.plugins"
		fi
	fi

	local keysfound=0
	local key
	local warn_keys="JumpFwd JumpRew JumpFwdSlow JumpRewSlow"
	local remote_file="${ROOT}"/etc/vdr/remote.conf

	if [[ -e ${remote_file} ]]; then
		for key in ${warn_keys}; do
			if grep -q -i "\.${key} " "${remote_file}"; then
				keysfound=1
				break
			fi
		done
		if [[ ${keysfound} == 1 ]]; then
			ewarn "Your /etc/vdr/remote.conf contains keys which are no longer usable"
			ewarn "Please remove these keys or vdr will not start:"
			ewarn "#  ${warn_keys}"
		fi
	fi

	elog "To get an idea how to proceed now, have a look at our vdr-guide:"
	elog "\thttp://www.gentoo.org/doc/en/vdr-guide.xml"
}
