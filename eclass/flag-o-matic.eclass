# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/flag-o-matic.eclass,v 1.96 2005/12/08 12:16:12 azarah Exp $


# need access to emktemp()
inherit eutils toolchain-funcs multilib

#
#### filter-flags <flags> ####
# Remove particular flags from C[XX]FLAGS
# Matches only complete flags
#
#### append-flags <flags> ####
# Add extra flags to your current C[XX]FLAGS
#
#### replace-flags <orig.flag> <new.flag> ###
# Replace a flag by another one
#
#### replace-cpu-flags <old.cpus> <new.cpu> ###
# Replace march/mcpu flags that specify <old.cpus>
# with flags that specify <new.cpu>
#
#### is-flag <flag> ####
# Returns "true" if flag is set in C[XX]FLAGS
# Matches only complete a flag
#
#### strip-flags ####
# Strip C[XX]FLAGS of everything except known
# good options.
#
#### strip-unsupported-flags ####
# Strip C[XX]FLAGS of any flags not supported by
# installed version of gcc
#
#### get-flag <flag> ####
# Find and echo the value for a particular flag
#
#### replace-sparc64-flags ####
# Sets mcpu to v8 and uses the original value
# as mtune if none specified.
#
#### filter-mfpmath <math types> ####
# Remove specified math types from the fpmath specification
# If the user has -mfpmath=sse,386, running `filter-mfpmath sse`
# will leave the user with -mfpmath=386
#
#### append-ldflags ####
# Add extra flags to your current LDFLAGS
#
#### filter-ldflags <flags> ####
# Remove particular flags from LDFLAGS
# Matches only complete flags
#
#### fstack-flags ####
# hooked function for hardened gcc that appends
# -fno-stack-protector to {C,CXX,LD}FLAGS
# when a package is filtering -fstack-protector, -fstack-protector-all
# notice: modern automatic specs files will also suppress -fstack-protector-all
# when only -fno-stack-protector is given
#
#### bindnow-flags ####
# Returns the flags to enable "now" binding in the current selected linker.
#
################ DEPRECATED functions ################
# The following are still present to avoid breaking existing
# code more than necessary; however they are deprecated. Please
# use gcc-specs-* from toolchain-funcs.eclass instead, if you
# need to know which hardened techs are active in the compiler.
# See bug #100974
#
#### has_hardened ####
# Returns true if the compiler has 'Hardened' in its version string,
# (note; switched-spec vanilla compilers satisfy this condition) or
# the specs file name contains 'hardened'.
#
#### has_pie ####
# Returns true if the compiler by default or with current CFLAGS
# builds position-independent code.
#
#### has_pic ####
# Returns true if the compiler by default or with current CFLAGS
# builds position-independent code.
#
#### has_ssp_all ####
# Returns true if the compiler by default or with current CFLAGS
# generates stack smash protections for all functions
#
#### has_ssp ####
# Returns true if the compiler by default or with current CFLAGS
# generates stack smash protections for most vulnerable functions
#

# C[XX]FLAGS that we allow in strip-flags
setup-allowed-flags() {
	if [[ -z ${ALLOWED_FLAGS} ]] ; then
		export ALLOWED_FLAGS="-pipe"
		export ALLOWED_FLAGS="${ALLOWED_FLAGS} -O -O0 -O1 -O2 -mcpu -march -mtune"
		export ALLOWED_FLAGS="${ALLOWED_FLAGS} -fstack-protector -fstack-protector-all"
		export ALLOWED_FLAGS="${ALLOWED_FLAGS} -fbounds-checking -fno-bounds-checking"
		export ALLOWED_FLAGS="${ALLOWED_FLAGS} -fno-pie -fno-unit-at-a-time"
		export ALLOWED_FLAGS="${ALLOWED_FLAGS} -g -g0 -g1 -g2 -g3 -ggdb -ggdb0 -ggdb1 -ggdb2 -ggdb3"
	fi
	# allow a bunch of flags that negate features / control ABI
	ALLOWED_FLAGS="${ALLOWED_FLAGS} -fno-stack-protector -fno-stack-protector-all"
	ALLOWED_FLAGS="${ALLOWED_FLAGS} -mregparm -mno-app-regs -mapp-regs \
		-mno-mmx -mno-sse -mno-sse2 -mno-sse3 -mno-3dnow \
		-mips1 -mips2 -mips3 -mips4 -mips32 -mips64 -mips16 \
		-msoft-float -mno-soft-float -mhard-float -mno-hard-float -mfpu \
		-mieee -mieee-with-inexact \
		-mtls-direct-seg-refs -mno-tls-direct-seg-refs \
		-mflat -mno-flat -mno-faster-structs -mfaster-structs \
		-m32 -m64 -mabi -mlittle-endian -mbig-endian -EL -EB -fPIC \
		-mlive-g0 -mcmodel -mstack-bias -mno-stack-bias"

	# C[XX]FLAGS that we are think is ok, but needs testing
	# NOTE:  currently -Os have issues with gcc3 and K6* arch's
	export UNSTABLE_FLAGS="-Os -O3 -freorder-blocks -fprefetch-loop-arrays"
	return 0
}

filter-flags() {
	local x f fset
	declare -a new_CFLAGS new_CXXFLAGS

	for x in "$@" ; do
		case "${x}" in
			-fPIC|-fpic|-fPIE|-fpie|-pie)
				append-flags `test_flag -fno-pie`;;
			-fstack-protector|-fstack-protector-all)
				fstack-flags;;
		esac
	done

	for fset in CFLAGS CXXFLAGS; do
		# Looping over the flags instead of using a global
		# substitution ensures that we're working with flag atoms.
		# Otherwise globs like -O* have the potential to wipe out the
		# list of flags.
		for f in ${!fset}; do
			for x in "$@"; do
				# Note this should work with globs like -O*
				[[ ${f} == ${x} ]] && continue 2
			done
			eval new_${fset}\[\${\#new_${fset}\[@]}]=\${f}
		done
		eval export ${fset}=\${new_${fset}\[*]}
	done

	return 0
}

filter-lfs-flags() {
	[[ -n $@ ]] && die "filter-lfs-flags takes no arguments"
	filter-flags -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
}

append-lfs-flags() {
	[[ -n $@ ]] && die "append-lfs-flags takes no arguments"
	append-flags -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE
}

append-flags() {
	[[ -z $* ]] && return 0
	export CFLAGS="${CFLAGS} $*"
	export CXXFLAGS="${CXXFLAGS} $*"
	[ -n "`is-flag -fno-stack-protector`" -o \
		-n "`is-flag -fno-stack-protector-all`" ] && fstack-flags
	return 0
}

replace-flags() {
	[[ $# != 2 ]] \
		&& echo && eerror "Usage: replace-flags <old flag> <new flag>" \
		&& die "replace-flags takes 2 arguments, not $#"

	local f fset
	declare -a new_CFLAGS new_CXXFLAGS

	for fset in CFLAGS CXXFLAGS; do
		# Looping over the flags instead of using a global
		# substitution ensures that we're working with flag atoms.
		# Otherwise globs like -O* have the potential to wipe out the
		# list of flags.
		for f in ${!fset}; do
			# Note this should work with globs like -O*
			[[ ${f} == ${1} ]] && f=${2}
			eval new_${fset}\[\${\#new_${fset}\[@]}]=\${f}
		done
		eval export ${fset}=\${new_${fset}\[*]}
	done

	return 0
}

replace-cpu-flags() {
	local newcpu="$#" ; newcpu="${!newcpu}"
	while [ $# -gt 1 ] ; do
		# quote to make sure that no globbing is done (particularly on
		# ${oldcpu} prior to calling replace-flags
		replace-flags "-march=${1}" "-march=${newcpu}"
		replace-flags "-mcpu=${1}" "-mcpu=${newcpu}"
		replace-flags "-mtune=${1}" "-mtune=${newcpu}"
		shift
	done
	return 0
}

is-flag() {
	local x

	for x in ${CFLAGS} ${CXXFLAGS} ; do
		# Note this should work with globs like -mcpu=ultrasparc*
		if [[ ${x} == ${1} ]]; then
			echo true
			return 0
		fi
	done
	return 1
}

filter-mfpmath() {
	local orig_mfpmath new_math prune_math

	# save the original -mfpmath flag
	orig_mfpmath="`get-flag -mfpmath`"
	# get the value of the current -mfpmath flag
	new_math=" `get-flag mfpmath | tr , ' '` "
	# figure out which math values are to be removed
	prune_math=""
	for prune_math in "$@" ; do
		new_math="${new_math/ ${prune_math} / }"
	done
	new_math="`echo ${new_math:1:${#new_math}-2} | tr ' ' ,`"

	if [ -z "${new_math}" ] ; then
		# if we're removing all user specified math values are
		# slated for removal, then we just filter the flag
		filter-flags ${orig_mfpmath}
	else
		# if we only want to filter some of the user specified
		# math values, then we replace the current flag
		replace-flags ${orig_mfpmath} -mfpmath=${new_math}
	fi
	return 0
}

strip-flags() {
	local x y flag NEW_CFLAGS NEW_CXXFLAGS

	setup-allowed-flags

	local NEW_CFLAGS=""
	local NEW_CXXFLAGS=""

	# Allow unstable C[XX]FLAGS if we are using unstable profile ...
	if has ~$(tc-arch) ${ACCEPT_KEYWORDS} ; then
		ALLOWED_FLAGS="${ALLOWED_FLAGS} ${UNSTABLE_FLAGS}"
	fi

	set -f	# disable pathname expansion

	for x in ${CFLAGS}; do
		for y in ${ALLOWED_FLAGS}; do
			flag=${x%%=*}
			if [ "${flag%%${y}}" = "" ] ; then
				NEW_CFLAGS="${NEW_CFLAGS} ${x}"
				break
			fi
		done
	done

	for x in ${CXXFLAGS}; do
		for y in ${ALLOWED_FLAGS}; do
			flag=${x%%=*}
			if [ "${flag%%${y}}" = "" ] ; then
				NEW_CXXFLAGS="${NEW_CXXFLAGS} ${x}"
				break
			fi
		done
	done

	# In case we filtered out all optimization flags fallback to -O2
	if [ "${CFLAGS/-O}" != "${CFLAGS}" -a "${NEW_CFLAGS/-O}" = "${NEW_CFLAGS}" ]; then
		NEW_CFLAGS="${NEW_CFLAGS} -O2"
	fi
	if [ "${CXXFLAGS/-O}" != "${CXXFLAGS}" -a "${NEW_CXXFLAGS/-O}" = "${NEW_CXXFLAGS}" ]; then
		NEW_CXXFLAGS="${NEW_CXXFLAGS} -O2"
	fi

	set +f	# re-enable pathname expansion

	export CFLAGS="${NEW_CFLAGS}"
	export CXXFLAGS="${NEW_CXXFLAGS}"
	return 0
}

test-flag-PROG() {
	local comp=$1
	local flags="$2"

	[[ -z ${comp} || -z ${flags} ]] && \
		return 1

	local PROG=$(tc-get${comp})
	${PROG} ${flags} -S -o /dev/null -xc /dev/null \
		> /dev/null 2>&1
}

# Returns true if C compiler support given flag
test-flag-CC() { test-flag-PROG "CC" "$1"; }

# Returns true if C++ compiler support given flag
test-flag-CXX() { test-flag-PROG "CXX" "$1"; }

test-flags() {
	local x
	
	for x in "$@" ; do
		test-flag-CC "${x}" || return 1
	done

	echo "$@"

	return 0
}

# Depriciated, use test-flags()
test_flag() {
	ewarn "test_flag: deprecated, please use test-flags()!" >/dev/stderr

	test-flags "$@"
}

test_version_info() {
	if [[ $($(tc-getCC) --version 2>&1) == *$1* ]]; then
		return 0
	else
		return 1
	fi
}

strip-unsupported-flags() {
	local x NEW_CFLAGS NEW_CXXFLAGS

	for x in ${CFLAGS} ; do
		NEW_CFLAGS="${NEW_CFLAGS} $(test-flags ${x})"
	done
	for x in ${CXXFLAGS} ; do
		NEW_CXXFLAGS="${NEW_CXXFLAGS} $(test-flags ${x})"
	done

	export CFLAGS=${NEW_CFLAGS}
	export CXXFLAGS=${NEW_CXXFLAGS}
}

get-flag() {
	local f findflag="$1"

	# this code looks a little flaky but seems to work for
	# everything we want ...
	# for example, if CFLAGS="-march=i686":
	# `get-flag -march` == "-march=i686"
	# `get-flag march` == "i686"
	for f in ${CFLAGS} ${CXXFLAGS} ; do
		if [ "${f/${findflag}}" != "${f}" ] ; then
			printf "%s\n" "${f/-${findflag}=}"
			return 0
		fi
	done
	return 1
}

# DEPRECATED - use gcc-specs-relro or gcc-specs-now from toolchain-funcs
has_hardened() {
	ewarn "has_hardened: deprecated, please use gcc-specs-{relro,now}()!" \
		>/dev/stderr
	
	test_version_info Hardened && return 0
	# The specs file wont exist unless gcc has GCC_SPECS support
	[[ -f ${GCC_SPECS} && ${GCC_SPECS} != ${GCC_SPECS/hardened/} ]]
}

# DEPRECATED - use gcc-specs-pie from toolchain-funcs
# indicate whether PIC is set
has_pic() {
	ewarn "has_pic: deprecated, please use gcc-specs-pie()!" >/dev/stderr
	
	[[ ${CFLAGS/-fPIC} != ${CFLAGS} || \
	   ${CFLAGS/-fpic} != ${CFLAGS} || \
	   -n $(echo | $(tc-getCC) ${CFLAGS} -E -dM - | grep __PIC__) ]]
}

# DEPRECATED - use gcc-specs-pie from toolchain-funcs
# indicate whether PIE is set
has_pie() {
	ewarn "has_pie: deprecated, please use gcc-specs-pie()!" >/dev/stderr
	
	[[ ${CFLAGS/-fPIE} != ${CFLAGS} || \
	   ${CFLAGS/-fpie} != ${CFLAGS} || \
	   -n $(echo | $(tc-getCC) ${CFLAGS} -E -dM - | grep __PIE__) || \
	   -n $(echo | $(tc-getCC) ${CFLAGS} -E -dM - | grep __PIC__) ]]
	# test PIC while waiting for specs to be updated to generate __PIE__
}

# DEPRECATED - use gcc-specs-ssp from toolchain-funcs
# indicate whether code for SSP is being generated for all functions
has_ssp_all() {
	ewarn "has_ssp_all: deprecated, please use gcc-specs-ssp()!" >/dev/stderr
	
	# note; this matches only -fstack-protector-all
	[[ ${CFLAGS/-fstack-protector-all} != ${CFLAGS} || \
	   -n $(echo | $(tc-getCC) ${CFLAGS} -E -dM - | grep __SSP_ALL__) ]] || \
	gcc-specs-ssp
}

# DEPRECATED - use gcc-specs-ssp from toolchain-funcs
# indicate whether code for SSP is being generated
has_ssp() {
	ewarn "has_ssp: deprecated, please use gcc-specs-ssp()!" >/dev/stderr
	
	# note; this matches both -fstack-protector and -fstack-protector-all
	[[ ${CFLAGS/-fstack-protector} != ${CFLAGS} || \
	   -n $(echo | $(tc-getCC) ${CFLAGS} -E -dM - | grep __SSP__) ]] || \
	gcc-specs-ssp
}

has_m64() {
	# this doesnt test if the flag is accepted, it tests if the flag
	# actually -WORKS-. non-multilib gcc will take both -m32 and -m64!
	# please dont replace this function with test_flag in some future
	# clean-up!
	
	local temp="$(emktemp)"
	echo "int main() { return(0); }" > "${temp}".c
	MY_CC=$(tc-getCC)
	${MY_CC/ .*/} -m64 -o "$(emktemp)" "${temp}".c > /dev/null 2>&1
	local ret=$?
	rm -f "${temp}".c
	[[ ${ret} != 1 ]] && return 0
	return 1
}

has_m32() {
	# this doesnt test if the flag is accepted, it tests if the flag
	# actually -WORKS-. non-multilib gcc will take both -m32 and -m64!
	# please dont replace this function with test_flag in some future
	# clean-up!

	[ "$(tc-arch)" = "amd64" ] && has_multilib_profile && return 0

	local temp=$(emktemp)
	echo "int main() { return(0); }" > "${temp}".c
	MY_CC=$(tc-getCC)
	${MY_CC/ .*/} -m32 -o "$(emktemp)" "${temp}".c > /dev/null 2>&1
	local ret=$?
	rm -f "${temp}".c
	[[ ${ret} != 1 ]] && return 0
	return 1
}

replace-sparc64-flags() {
	local SPARC64_CPUS="ultrasparc v9"

	if [ "${CFLAGS/mtune}" != "${CFLAGS}" ]; then
		for x in ${SPARC64_CPUS}; do
			CFLAGS="${CFLAGS/-mcpu=${x}/-mcpu=v8}"
		done
	else
	 	for x in ${SPARC64_CPUS}; do
			CFLAGS="${CFLAGS/-mcpu=${x}/-mcpu=v8 -mtune=${x}}"
		done
	fi

	if [ "${CXXFLAGS/mtune}" != "${CXXFLAGS}" ]; then
		for x in ${SPARC64_CPUS}; do
			CXXFLAGS="${CXXFLAGS/-mcpu=${x}/-mcpu=v8}"
		done
	else
	 	for x in ${SPARC64_CPUS}; do
			CXXFLAGS="${CXXFLAGS/-mcpu=${x}/-mcpu=v8 -mtune=${x}}"
		done
	fi

	export CFLAGS CXXFLAGS
}

append-ldflags() {
	export LDFLAGS="${LDFLAGS} $*"
	return 0
}

filter-ldflags() {
	local x

	# we do this fancy spacing stuff so as to not filter
	# out part of a flag ... we want flag atoms ! :D
	LDFLAGS=" ${LDFLAGS} "
	for x in "$@" ; do
		LDFLAGS=${LDFLAGS// ${x} / }
	done
	[[ -z ${LDFLAGS// } ]] \
		&& LDFLAGS="" \
		|| LDFLAGS=${LDFLAGS:1:${#LDFLAGS}-2}
	export LDFLAGS
	return 0
}

fstack-flags() {
	if gcc-specs-ssp; then
		[ -z "`is-flag -fno-stack-protector`" ] &&
			export CFLAGS="${CFLAGS} `test_flag -fno-stack-protector`"
	fi
	return 0
}

# This is thanks to great work from Paul de Vrieze <gentoo-user@devrieze.net>,
# bug #9016.  Also thanks to Jukka Salmi <salmi@gmx.net> (bug #13907) for more
# fixes.
#
# Export CFLAGS and CXXFLAGS that are compadible with gcc-2.95.3
gcc2-flags() {
	if [[ $(tc-arch) == "x86" || $(tc-arch) == "amd64" ]] ; then
		CFLAGS=${CFLAGS//-mtune=/-mcpu=}
		CXXFLAGS=${CXXFLAGS//-mtune=/-mcpu=}
	fi

	replace-cpu-flags k6-{2,3} k6
	replace-cpu-flags athlon{,-{tbird,4,xp,mp}} i686

	replace-cpu-flags pentium-mmx i586
	replace-cpu-flags pentium{2,3,4} i686

	replace-cpu-flags ev6{7,8} ev6

	export CFLAGS CXXFLAGS
}

# Gets the flags needed for "NOW" binding
bindnow-flags() {
	case $($(tc-getLD) -v 2>&1 </dev/null) in
	*GNU* | *'with BFD'*) # GNU ld
		echo "-Wl,-z,now" ;;
	*Apple*) # Darwin ld
		echo "-bind_at_load" ;;
	*)
		# Some linkers just recognize -V instead of -v
		case $($(tc-getLD) -V 2>&1 </dev/null) in
			*Solaris*) # Solaris accept almost the same GNU options
				echo "-Wl,-z,now" ;;
		esac
		;;
	esac
}
