# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/oracle-instantclient-basic/oracle-instantclient-basic-11.2.0.3.ebuild,v 1.5 2012/03/09 17:04:41 haubi Exp $

EAPI="4"

inherit eutils multilib

MY_PLAT_x86="Linux x86"
MY_BITS_x86=32
MY_A_x86="${PN/oracle-/}-linux-${PV}.0.zip"
MY_ASDK_x86="${MY_A_x86/basic/sdk}"

MY_PLAT_amd64="Linux x86-64"
MY_BITS_amd64=64
MY_A_amd64="${PN/oracle-}-linux.x64-${PV}.0.zip"
MY_ASDK_amd64="${MY_A_amd64/basic/sdk}"

DESCRIPTION="Oracle 11g Instant Client with SDK"
HOMEPAGE="http://www.oracle.com/technetwork/database/features/instant-client/index.html"
SRC_URI="
	x86?   ( ${MY_A_x86}   ${MY_ASDK_x86}                             )
	amd64? ( ${MY_A_amd64} ${MY_ASDK_amd64} multilib? ( ${MY_A_x86} ) )
"

LICENSE="OTN"
SLOT="0"
KEYWORDS="~x86 ~amd64"
RESTRICT="fetch"
IUSE="multilib"

EMULTILIB_PKG="true"

DEPEND="app-arch/unzip"
RDEPEND="
	dev-libs/libaio
	multilib? ( >=dev-libs/libaio-0.3.109-r3 )
"

S="${WORKDIR}"

set_my_abivars() {
	S="${WORKDIR}/${ABI}/instantclient_11_2"

	local abi=${ABI}
	[[ ${abi} == 'default' ]] && abi=${ARCH}
	MY_PLAT=MY_PLAT_${abi}; MY_PLAT=${!MY_PLAT} # platform name
	MY_BITS=MY_BITS_${abi}; MY_BITS=${!MY_BITS} # platform bitwidth
	MY_A=MY_A_${abi}      ; MY_A=${!MY_A}       # runtime distfile
	MY_ASDK=MY_ASDK_${abi}; MY_ASDK=${!MY_ASDK} # sdk distfile

	[[ -n ${MY_PLAT} ]]
}

pkg_nofetch() {
	eerror "Please go to"
	eerror "  ${HOMEPAGE%/*}/index-097480.html"
	eerror "  and download"
	for ABI in $(get_install_abis)
	do
		set_my_abivars || continue
		eerror "Instant Client for ${MY_PLAT}"
		eerror "    Basic: ${MY_A}"
		if is_final_abi; then
			eerror "    SDK:   ${MY_ASDK}"
		fi
	done
	eerror "After downloading, put them in:"
	eerror "    ${DISTDIR}/"
}

src_unpack() {
	for ABI in $(get_install_abis)
	do
		set_my_abivars || continue
		mkdir "${WORKDIR}"/${ABI} || die
		cd "${WORKDIR}"/${ABI} || die
		unpack ${MY_A}
		if is_final_abi; then
			unpack ${MY_ASDK}
		fi
	done
}

src_prepare() {
	# need to patch for the final ABI only
	set_my_abivars || die "${ABI} ABI not supported!"
	cd "${S}" || die
	epatch "${FILESDIR}"/11.2.0.3-makefile.patch
}

src_install() {
	# all binaries go here
	local oracle_home=/usr/$(get_libdir)/oracle/${PV}/client
	into "${oracle_home}"

	local ldpath=
	for ABI in $(get_install_abis) # last iteration is final ABI
	do
		if ! set_my_abivars; then
			elog "Skipping unsupported ABI ${ABI}."
			continue
		fi
		einfo "Installing runtime for ${MY_PLAT} ..."

		cd "${S}" || die

		# shared libraries
		dolib.so lib*$(get_libname)*

		# ensure to be linkable
		[[ -e libocci$(get_libname) ]] ||
		dosym libocci$(get_libname 11.1) \
			"${oracle_home}"/$(get_libdir)/libocci$(get_libname)
		[[ -e libclntsh$(get_libname) ]] ||
		dosym libclntsh$(get_libname 11.1) \
			"${oracle_home}"/$(get_libdir)/libclntsh$(get_libname)

		# java archives
		insinto "${oracle_home}"/$(get_libdir)
		doins *.jar

		# runtime library path
		ldpath+=${ldpath:+:}${oracle_home}/$(get_libdir)

		eend $?
	done

	# ensure ORACLE_HOME/lib exists
	[[ -e ${ED}${oracle_home}/lib ]] ||
	dosym $(get_libdir) "${oracle_home}"/lib

	einfo "Installing SDK ..."
	cd "${S}"/sdk || die

	# SDK makefile, for #165834
	# As we change the relative filesystem layout compared
	# to vanilla instantclient.zip content, it feels easier
	# to fake the layout found in Oracle eXpress Edition.
	# Both layouts are known to DBD::Oracle (cpan).
	insinto "${oracle_home}"/rdbms/demo
	newins demo/demo.mk demo_xe.mk

	# Remove ldap.h, #299562
	rm include/ldap.h || die
	# DBD::Oracle needs rdbms/public as real directory
	insinto "${oracle_home}"/rdbms/public
	doins include/*.h
	dosym rdbms/public "${oracle_home}"/include
	# ruby-oci8 expects the headers here
	dosym "${oracle_home}"/rdbms/public /usr/include/oracle/${PV}/client

	dodoc demo/*

	eend $?

	# create path for tnsnames.ora
	dodir /etc/oracle

	# Add OCI libs to library path
	{
		echo "ORACLE_HOME=${EPREFIX}${oracle_home}"
		echo "LDPATH=${ldpath}"
# who does need this?
#		echo "C_INCLUDE_PATH=${oracle_home}/include"
		echo "TNS_ADMIN=/etc/oracle/"
	} > "${T}"/50oracle-instantclient-basic
	doenvd "${T}"/50oracle-instantclient-basic
}

pkg_postinst() {
	elog "TNS_ADMIN has been set to ${EROOT}etc/oracle by default,"
	elog "put your tnsnames.ora there or configure TNS_ADMIN"
	elog "to point to your user specific configuration."
}
