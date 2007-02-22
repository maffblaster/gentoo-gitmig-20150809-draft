# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/mozilla-sunbird/mozilla-sunbird-0.3.1.ebuild,v 1.1 2007/02/22 21:27:34 armin76 Exp $

WANT_AUTOCONF="2.1"

inherit flag-o-matic toolchain-funcs eutils mozconfig-2 mozilla-launcher makeedit multilib fdo-mime mozextension autotools

LANGS="ca cs da de es-ES eu fr hu it mn nl pl ru sk sl"

MY_PN="${PN/mozilla-}"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="The Mozilla Sunbird Calendar"
HOMEPAGE="http://www.mozilla.org/projects/calendar/sunbird.html"
IUSE="mozbranding"
SRC_URI="http://releases.mozilla.org/pub/mozilla.org/calendar/${MY_PN}/releases/${PV}/source/${MY_P}.source.tar.bz2"

# These are in
#
#  http://releases.mozilla.org/pub/mozilla.org/calendar/sunbird/releases/${PV}/langpacks/
#
# for i in $LANGS $SHORTLANGS; do wget $i.xpi -O ${P}-$i.xpi; done
for X in ${LANGS} ; do
	SRC_URI="${SRC_URI}
		linguas_${X/-/_}? ( http://releases.mozilla.org/pub/mozilla.org/calendar/${MY_PN}/releases/${PV}/langpacks/${MY_PN}-${PV}.${X}.langpack.xpi )"
	IUSE="${IUSE} linguas_${X/-/_}"
	# english is handled internally
done

KEYWORDS="-* ~x86 ~amd64"
SLOT="0"
LICENSE="MPL-1.1 GPL-2 LGPL-2.1"

RDEPEND=">=www-client/mozilla-launcher-1.44
	>=dev-libs/nss-3.10"

S="${WORKDIR}/mozilla"

linguas() {
	local LANG SLANG
	for LANG in ${LINGUAS}; do
		if has ${LANG} en en_US; then
			has en ${linguas} || linguas="${linguas:+"${linguas} "}en"
			continue
		elif has ${LANG} ${LANGS//-/_}; then
			has ${LANG//_/-} ${linguas} || linguas="${linguas:+"${linguas} "}${LANG//_/-}"
			continue
		elif [[ " ${LANGS} " == *" ${LANG}-"* ]]; then
			for X in ${LANGS}; do
				if [[ "${X}" == "${LANG}-"* ]] &&  != *" ${X} "* ]]; then
					has ${X} ${linguas} || linguas="${linguas:+"${linguas} "}${X}"
					continue 2
				fi
			done
		fi
		ewarn "Sorry, but ${PN} does not support the ${LANG} LINGUA"
	done
	einfo "Selected language packs (first will be default): $linguas"
}

pkg_setup(){
	if ! built_with_use x11-libs/cairo X; then
		eerror "Cairo is not built with X useflag."
		eerror "Please add 'X' to your USE flags, and re-emerge cairo."
		die "Cairo needs X"
	fi

	if use mozbranding; then
		einfo "You are enabling official branding. You may not redistribute this build"
		einfo "to any users on your network or the internet. Doing so puts yourself into"
		einfo "a legal problem with mozilla foundation"
	fi

	use moznopango && warn_mozilla_launcher_stub
}

src_unpack() {
	unpack ${A%bz2*}bz2

	linguas
	for X in ${linguas}; do
		[[ ${X} != "en" ]] && xpi_unpack "${MY_PN}-${PV}.${X}.langpack.xpi"
	done

	cd "${S}"
	epatch "${FILESDIR}/${P}-add-missing-LDFLAGS.patch"

	eautoreconf
}

src_compile() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	####################################
	#
	# mozconfig, CFLAGS and CXXFLAGS setup
	#
	####################################

	mozconfig_init
	mozconfig_config

	mozconfig_annotate '' --enable-application=calendar
	mozconfig_annotate '' --enable-extensions=default
	mozconfig_annotate '' --with-default-mozilla-five-home=${MOZILLA_FIVE_HOME}
	mozconfig_annotate '' --with-system-nss
	mozconfig_annotate '' --with-system-nspr

	if use mozbranding; then
		mozconfig_annotate '' --enable-official-branding
	fi

	# Add build variables
	mozconfig_build_opts

	# Finalize and report settings
	mozconfig_final

	# hardened GCC uses -fstack-protector-all by default, which breaks us
	gcc-specs-ssp && append-flags -fno-stack-protector-all
	replace-flags -fstack-protector-all -fstack-protector

	####################################
	#
	#  Configure and build
	#
	####################################

	CPPFLAGS="${CPPFLAGS} -DARON_WAS_HERE" \
	CC="$(tc-getCC)" CXX="$(tc-getCXX)" LD="$(tc-getLD)" \
	econf || die

	# It would be great if we could pass these in via CPPFLAGS or CFLAGS prior
	# to econf, but the quotes cause configure to fail.
	sed -i -e \
		's|-DARON_WAS_HERE|-DGENTOO_NSPLUGINS_DIR=\\\"/usr/'"$(get_libdir)"'/nsplugins\\\" -DGENTOO_NSBROWSER_PLUGINS_DIR=\\\"/usr/'"$(get_libdir)"'/nsbrowser/plugins\\\"|' \
		${S}/config/autoconf.mk \
		${S}/nsprpub/config/autoconf.mk \
		${S}/xpfe/global/buildconfig.html

	# This removes extraneous CFLAGS from the Makefiles to reduce RAM
	# requirements while compiling
	edit_makefiles

	emake -j1 || die
}

pkg_preinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	einfo "Removing old installs though some really ugly code.  It potentially"
	einfo "eliminates any problems during the install, however suggestions to"
	einfo "replace this are highly welcome.  Send comments and suggestions to"
	einfo "mozilla@gentoo.org."
	rm -rf "${ROOT}"/"${MOZILLA_FIVE_HOME}"
}

src_install() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	# Most of the installation happens here
	dodir "${MOZILLA_FIVE_HOME}"
	cp -RL "${S}/dist/bin/"* "${D}${MOZILLA_FIVE_HOME}" || die "Copy of files failed"

	linguas
	for X in ${linguas}; do
		[[ ${X} != "en" ]] && xpi_install "${WORKDIR}"/"${MY_PN}-${PV}.${X}.langpack"
	done

	local LANG=${linguas%% *}
	if [[ -n ${LANG} && ${LANG} != "en" ]]; then
		einfo "Setting default locale to ${LANG}"
		dosed -e "s:general.useragent.locale\", \"en-US\":general.useragent.locale\", \"${LANG}\":" \
			"${MOZILLA_FIVE_HOME}"/defaults/pref/sunbird.js \
			"${MOZILLA_FIVE_HOME}"/defaults/pref/sunbird-l10n.js || \
			die "sed failed to change locale"
	fi

	# Create /usr/bin/sunbird
	install_mozilla_launcher_stub sunbird "${MOZILLA_FIVE_HOME}"

	# Install icon and .desktop for menu entry
	if use mozbranding; then
		doicon "${FILESDIR}"/icon/${PN}-icon.png
		domenu "${FILESDIR}"/icon/${PN}.desktop
	else
		doicon "${FILESDIR}"/icon/${PN}-unbranded-icon.png
		newmenu "${FILESDIR}"/icon/${PN}-unbranded.desktop \
			${PN}.desktop

	fi
}

pkg_postinst() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	# This should be called in the postinst and postrm of all the
	# mozilla, mozilla-bin, firefox, firefox-bin, thunderbird and
	# thunderbird-bin ebuilds.
	update_mozilla_launcher_symlinks
}

pkg_postrm() {
	declare MOZILLA_FIVE_HOME="/usr/$(get_libdir)/${PN}"

	update_mozilla_launcher_symlinks
}
