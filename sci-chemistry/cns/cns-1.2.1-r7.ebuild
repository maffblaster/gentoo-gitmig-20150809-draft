# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/cns/cns-1.2.1-r7.ebuild,v 1.1 2011/08/30 13:48:39 jlec Exp $

EAPI=3

inherit eutils fortran-2 toolchain-funcs versionator flag-o-matic

MY_PN="${PN}_solve"
MY_PV="$(delete_version_separator 2)"
MY_P="${MY_PN}_${MY_PV}"

DESCRIPTION="Crystallography and NMR System"
HOMEPAGE="http://cns.csb.yale.edu/"
SRC_URI="
	${MY_P}_all-mp.tar.gz
	aria? ( aria2.3.2.tar.gz )"

SLOT="0"
LICENSE="cns"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="aria openmp"

RDEPEND="
	virtual/fortran
	app-shells/tcsh"
DEPEND="${RDEPEND}"

FORTRAN_NEED_OPENMP=1

S="${WORKDIR}/${MY_P}"

RESTRICT="fetch"

pkg_nofetch() {
	elog "Fill out the form at http://cns.csb.yale.edu/cns_request/"
	use aria && elog "and http://aria.pasteur.fr/"
	elog "and place these files:"
	elog ${A}
	elog "in ${DISTDIR}."
}

get_fcomp() {
	case $(tc-getFC) in
		*gfortran* )
			FCOMP="gfortran" ;;
		ifort )
			FCOMP="ifc" ;;
		* )
			FCOMP=$(tc-getFC) ;;
	esac
}

pkg_setup() {
	fortran-2_pkg_setup
	get_fcomp
}

get_bitness() {
	echo > "${T}"/test.c
	$(tc-getCC) ${CFLAGS} -c "${T}"/test.c -o "${T}"/test.o
	case $(file "${T}"/test.o) in
		*64-bit*|*ppc64*|*x86_64*) export _bitness="64";;
		*32-bit*|*ppc*|*i386*) export _bitness="32";;
		*) die "Failed to detect whether your arch is 64bits or 32bits, disable distcc if you're using it, please";;
	esac
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${PV}-gentoo.patch \
		"${FILESDIR}"/${PV}-parallel.patch

	get_bitness

	if use aria; then
	pushd "${WORKDIR}"/aria* >& /dev/null
		# Update the cns sources in aria for version 1.2.1
		epatch "${FILESDIR}"/1.2.1-aria2.3.patch

		# Update the code with aria specific things
		cp -rf cns/src/* "${S}"/source/
	popd >& /dev/null
	fi

	# the code uses Intel-compiler-specific directives
	if [[ $(tc-getFC) =~ gfortran ]]; then
		epatch "${FILESDIR}"/${PV}-allow-gcc-openmp.patch
		use openmp && \
			append-flags -fopenmp && append-ldflags -fopenmp
		COMP="gfortran"
		[[ ${_bitness} == 64 ]] && \
			append-fflags -fdefault-integer-8
	elif [[ $(tc-getFC) == if* ]]; then
		epatch "${FILESDIR}"/${PV}-ifort.patch
		use openmp && \
			append-flags -openmp && append-ldflags -openmp
		COMP="ifort"
		[[ ${_bitness} == 64 ]] && append-fflags -i8
	fi

	[[ ${_bitness} == 64 ]] && \
		append-cflags "-DINTEGER='long long int'"

	# Set up location for the build directory
	# Uses obsolete `sort` syntax, so we set _POSIX2_VERSION
	cp "${FILESDIR}"/cns_solve_env_sh "${T}"/
	sed -i \
		-e "s:_CNSsolve_location_:${S}:g" \
		-e "17 s:\(.*\):\1\nsetenv _POSIX2_VERSION 199209:g" \
		"${S}"/cns_solve_env
	sed -i \
		-e "s:_CNSsolve_location_:${S}:g" \
		-e "17 s:\(.*\):\1\nexport _POSIX2_VERSION; _POSIX2_VERSION=199209:g" \
		"${T}"/cns_solve_env_sh

	einfo "Fixing shebangs..."
	find "${S}" -type f \
		-exec sed "s:/bin/csh:${EPREFIX}/bin/csh:g" -i '{}' \; || die
}

src_compile() {
	local GLOBALS
	local MALIGN
	if [[ $(tc-getFC) =~ g77 ]]; then
		GLOBALS="-fno-globals"
		MALIGN='\$(CNS_MALIGN_I86)'
	fi

	# Set up the compiler to use
	pushd instlib/machine/unsupported/g77-unix 2>/dev/null
	ln -s Makefile.header Makefile.header.${FCOMP} || die
	popd 2>/dev/null

	# make install really means build, since it's expected to be used in-place
	# -j1 doesn't mean we do no respect MAKEOPTS!
	emake -j1 \
		CC="$(tc-getCC)" \
		F77=$(tc-getFC) \
		LD=$(tc-getFC) \
		CCFLAGS="${CFLAGS} -DCNS_ARCH_TYPE_\$(CNS_ARCH_TYPE) \$(EXT_CCFLAGS)" \
		LDFLAGS="${LDFLAGS}" \
		F77OPT="${FFLAGS:- -O2} ${MALIGN}" \
		F77STD="${GLOBALS}" \
		OMPLIB="${OMPLIB}" \
		compiler="${COMP}" \
		install \
		|| die "emake failed"
}

src_test() {
	# We need to force on g77 manually, because we can't get aliases working
	# when we source in a -c
	einfo "Running tests ..."
	sh -c \
		"export CNS_G77=ON; source ${T}/cns_solve_env_sh; make run_tests" \
		|| die "tests failed"
	einfo "Displaying test results ..."
	cat "${S}"/*_g77/test/*.diff-test
}

src_install() {
	# Install to locations resembling FHS
	sed -i \
		-e "s:${S}:usr:g" \
		-e "s:^\(setenv CNS_SOLVE.*\):\1\nsetenv CNS_ROOT ${EPREFIX}/usr:g" \
		-e "s:^\(setenv CNS_SOLVE.*\):\1\nsetenv CNS_DATA \$CNS_ROOT/share/cns:g" \
		-e "s:^\(setenv CNS_SOLVE.*\):\1\nsetenv CNS_DOC \$CNS_ROOT/share/doc/${PF}:g" \
		-e "s:CNS_LIB \$CNS_SOLVE/libraries:CNS_LIB \$CNS_DATA/libraries:g" \
		-e "s:CNS_MODULE \$CNS_SOLVE/modules:CNS_MODULE \$CNS_DATA/modules:g" \
		-e "s:CNS_HELPLIB \$CNS_SOLVE/helplib:CNS_HELPLIB \$CNS_DATA/helplib:g" \
		-e "s:\$CNS_SOLVE/bin/cns_info:\$CNS_DATA/cns_info:g" \
		-e "/^g77on/d" \
		"${S}"/cns_solve_env
	# I don't entirely understand why the sh version requires a leading /
	# for CNS_SOLVE and CNS_ROOT, but it does
	sed -i \
		-e "s:${S}:/usr:g" \
		-e "s:^\(^[[:space:]]*CNS_SOLVE=.*\):\1\nexport CNS_ROOT=${EPREFIX}/usr:g" \
		-e "s:^\(^[[:space:]]*CNS_SOLVE=.*\):\1\nexport CNS_DATA=\$CNS_ROOT/share/cns:g" \
		-e "s:^\(^[[:space:]]*CNS_SOLVE=.*\):\1\nexport CNS_DOC=\$CNS_ROOT/share/doc/${PF}:g" \
		-e "s:CNS_LIB=\$CNS_SOLVE/libraries:CNS_LIB=\$CNS_DATA/libraries:g" \
		-e "s:CNS_MODULE=\$CNS_SOLVE/modules:CNS_MODULE=\$CNS_DATA/modules:g" \
		-e "s:CNS_HELPLIB=\$CNS_SOLVE/helplib:CNS_HELPLIB=\$CNS_DATA/helplib:g" \
		-e "s:\$CNS_SOLVE/bin/cns_info:\$CNS_DATA/cns_info:g" \
		-e "/^g77on/d" \
		-e "/^g77off/d" \
		"${T}"/cns_solve_env_sh

	# Get rid of setup stuff we don't need in the installed script
	sed -i \
		-e "83,$ d" \
		-e "37,46 d" \
		"${S}"/cns_solve_env
	sed -i \
		-e "84,$ d" \
		-e "39,50 d" \
		"${T}"/cns_solve_env_sh

	newbin "${S}"/*linux*/bin/cns_solve* cns_solve \
		|| die "install cns_solve failed"

	# Can be run by either cns_solve or cns
	dosym cns_solve /usr/bin/cns

	# Don't want to install this
	rm -f "${S}"/*linux*/utils/Makefile

	dobin "${S}"/*linux*/utils/* || die "install utils failed"

	sed -i \
		-e "s:\$CNS_SOLVE/doc/:\$CNS_SOLVE/share/doc/${PF}/:g" \
		"${S}"/bin/cns_web || die

	dobin "${S}"/bin/cns_{edit,header,transfer,web} || die "install bin failed"

	insinto /usr/share/cns
	doins -r "${S}"/libraries "${S}"/modules "${S}"/helplib || die
	doins "${S}"/bin/cns_info || die

	insinto /etc/profile.d
	newins "${S}"/cns_solve_env cns_solve_env.csh || die
	newins "${T}"/cns_solve_env_sh cns_solve_env.sh || die

	dohtml \
		-A iq,cgi,csh,cv,def,fm,gif,hkl,inp,jpeg,lib,link,list,mask,mtf,param,pdb,pdf,pl,ps,sc,sca,sdb,seq,tbl,top \
		-f all_cns_info_template,omac,def \
		-r doc/html/* || die
	# Conflits with app-text/dos2unix
	rm -f "${D}"/usr/bin/dos2unix
}

pkg_info() {
	if use openmp; then
		elog "Set OMP_NUM_THREADS to the number of threads you want."
		elog "If you get segfaults on large structures, set the GOMP_STACKSIZE"
		elog "variable if using gcc (16384 should be good)."
	fi
}

pkg_postinst() {
	pkg_info
}
