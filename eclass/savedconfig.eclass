# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/savedconfig.eclass,v 1.17 2012/01/04 06:19:09 vapier Exp $

# @ECLASS: savedconfig.eclass
# @MAINTAINER:
# base-system@gentoo.org
# @BLURB: common API for saving/restoring complex configuration files
# @DESCRIPTION:
# It is not uncommon to come across a package which has a very fine
# grained level of configuration options that go way beyond what
# USE flags can properly describe.  For this purpose, a common API
# of saving and restoring the configuration files was developed
# so users can modify these config files and the ebuild will take it
# into account as needed.

inherit portability

IUSE="savedconfig"

# @FUNCTION: save_config
# @USAGE: <config files to save>
# @DESCRIPTION:
# Use this function to save the package's configuration file into the
# right location.  You may specify any number of configuration files,
# but just make sure you call save_config with all of them at the same
# time in order for things to work properly.
save_config() {
	if [[ ${EBUILD_PHASE} != "install" ]]; then
		die "Bad package!  save_config only for use in src_install functions!"
	fi
	[[ $# -eq 0 ]] && die "Usage: save_config <files>"

	# Be lazy in our EAPI compat
	: ${ED:-${D}}

	local dest="/etc/portage/savedconfig/${CATEGORY}"
	if [[ $# -eq 1 && -f $1 ]] ; then
		# Just one file, so have the ${PF} be that config file
		dodir "${dest}"
		cp "$@" "${ED}/${dest}/${PF}" || die "failed to save $*"
	else
		# A dir, or multiple files, so have the ${PF} be a dir
		# with all the saved stuff below it
		dodir "${dest}/${PF}"
		treecopy "$@" "${ED}/${dest}/${PF}" || die "failed to save $*"
	fi

	elog "Your configuration for ${CATEGORY}/${PF} has been saved in "
	elog "/etc/portage/savedconfig/${CATEGORY}/${PF} for your editing pleasure."
	elog "You can edit these files by hand and remerge this package with"
	elog "USE=savedconfig to customise the configuration."
	elog "You can rename this file/directory to one of the following for"
	elog "its configuration to apply to multiple versions:"
	elog '${PORTAGE_CONFIGROOT}/etc/portage/savedconfig/'
	elog '[${CTARGET}|${CHOST}|""]/${CATEGORY}/[${PF}|${P}|${PN}]'
}

# @FUNCTION: restore_config
# @USAGE: <config files to restore>
# @DESCRIPTION:
# Restores the configuation saved ebuild previously potentially with user edits.
# You can restore a single file or a whole bunch, just make sure you call
# restore_config with all of the files to restore at the same time.
#
# Config files can be laid out as:
# @CODE
# ${PORTAGE_CONFIGROOT}/etc/portage/savedconfig/${CTARGET}/${CATEGORY}/${PF}
# ${PORTAGE_CONFIGROOT}/etc/portage/savedconfig/${CHOST}/${CATEGORY}/${PF}
# ${PORTAGE_CONFIGROOT}/etc/portage/savedconfig/${CATEGORY}/${PF}
# ${PORTAGE_CONFIGROOT}/etc/portage/savedconfig/${CTARGET}/${CATEGORY}/${P}
# ${PORTAGE_CONFIGROOT}/etc/portage/savedconfig/${CHOST}/${CATEGORY}/${P}
# ${PORTAGE_CONFIGROOT}/etc/portage/savedconfig/${CATEGORY}/${P}
# ${PORTAGE_CONFIGROOT}/etc/portage/savedconfig/${CTARGET}/${CATEGORY}/${PN}
# ${PORTAGE_CONFIGROOT}/etc/portage/savedconfig/${CHOST}/${CATEGORY}/${PN}
# ${PORTAGE_CONFIGROOT}/etc/portage/savedconfig/${CATEGORY}/${PN}
# @CODE
restore_config() {
	use savedconfig || return

	case ${EBUILD_PHASE} in
		unpack|compile|configure|prepare) ;;
		*) die "Bad package!  restore_config only for use in src_{unpack,compile,configure,prepare} functions!" ;;
	esac
	local found check configfile
	local base=${PORTAGE_CONFIGROOT}/etc/portage/savedconfig
	for check in {${CATEGORY}/${PF},${CATEGORY}/${P},${CATEGORY}/${PN}}; do
		configfile=${base}/${CTARGET}/${check}
		[[ -r ${configfile} ]] || configfile=${base}/${CHOST}/${check}
		[[ -r ${configfile} ]] || configfile=${base}/${check}
		einfo "Checking existence of ${configfile} ..."
		if [[ -r "${configfile}" ]]; then
			einfo "found ${configfile}"
			found=${configfile};
			break;
		fi
	done
	if [[ -f ${found} ]]; then
		elog "Building using saved configfile ${found}"
		if [ $# -gt 0 ]; then
			cp -pPR	"${found}" "$1" || die "Failed to restore ${found} to $1"
		else
			die "need to know the restoration filename"
		fi
	elif [[ -d ${found} ]]; then
		elog "Building using saved config directory ${found}"
		local dest=${PWD}
		pushd "${found}" > /dev/null
		treecopy . "${dest}" || die "Failed to restore ${found} to $1"
		popd > /dev/null
	else
		# maybe the user is screwing around with perms they shouldnt #289168
		if [[ ! -r ${base} ]] ; then
			eerror "Unable to read ${base} -- please check its permissions."
			die "Reading config files failed"
		fi
		ewarn "No saved config to restore - please remove USE=savedconfig or"
		ewarn "provide a configuration file in ${PORTAGE_CONFIGROOT}/etc/portage/savedconfig/${CATEGORY}/${PN}"
		ewarn "Your config file(s) will not be used this time"
	fi
}
