# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/games-ut2k4mod.eclass,v 1.3 2005/02/24 13:51:36 wolf31o2 Exp $

inherit games

ECLASS=games-ut2k4mod
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS pkg_fetch src_unpack src_install pkg_postinst

DESCRIPTION="UT2004 - ${MOD_DESC}"

SLOT="0"
KEYWORDS="-* x86 amd64"
IUSE=""
RESTRICT="nomirror fetch"

DEPEND="app-arch/tar
	app-arch/bzip2"

RDEPEND="virtual/libc
	>=games-fps/ut2004-3339"

S=${WORKDIR}
dir=${GAMES_PREFIX_OPT}/ut2004
Ddir=${D}/${dir}

check_dvd() {
	# The following is a nasty mess to determine if we are installing from
	# a DVD or from multiple CDs.  Anyone feel free to submit patches to this
	# to bugs.gentoo.org as I know it is a very ugly hack.
	USE_DVD=
	USE_ECE_DVD=
	if [ -n "${CD_ROOT}" ]
	then
		[ -d "${CD_ROOT}/CD1" ] && USE_DVD=1
		[ -d "${CD_ROOT}/CD7" ] && USE_ECE_DVD=1
	else
		local mline=""
		for mline in `mount | egrep -e '(iso|cdrom)' | awk '{print $3}'`
		do
			[ -d "${mline}/CD1" ] && USE_DVD=1
			[ -d "${mline}/CD7" ] && USE_ECE_DVD=1
		done
	fi
}

games-ut2k4mod_pkg_fetch() {
	einfo "Please download ${A} and put it into ${DISTDIR}"
	einfo "http://liflg.org/?catid=6&gameid=17"
}

games-ut2k4mod_src_unpack() {
	dodir ${dir}
	unpack_makeself
	mkdir ${S}/unpack
	if [ -e ${MOD_TBZ2}_${PV}-english.tar.bz2 ]
	then
		tar xjf ${MOD_TBZ2}_${PV}-english.tar.bz2 -C ${S}/unpack \
			|| die "uncompressing tarball"
	elif [ -e ${MOD_TBZ2}_${PV}.tar.bz2 ]
	then
		tar xjf ${MOD_TBZ2}_${PV}.tar.bz2 -C ${S}/unpack \
			|| die "uncompressing tarball"
	else
		tar xjf ${MOD_TBZ2}.tar.bz2 -C ${S}/unpack \
			|| die "uncompressing tarball"
	fi
}

games-ut2k4mod_src_install() {
	[ -z "${MOD_NAME}" ] && die "what is the name of this ut2k4mod ?"

	dodir ${dir}
	cp -r ${S}/unpack/* ${Ddir}

	if [ -e ${S}/README.${MOD_BINS} ]
	then
		dodoc README.${MOD_BINS} || die "dodoc failed"
	else
		dodoc README.${MOD_TBZ2} || die "dodoc failed"
	fi
	exeinto ${dir}
	doexe bin/${MOD_BINS} || die "doexe failed"

	games_make_wrapper ${MOD_BINS} ./${MOD_BINS} ${dir}

	insinto /usr/share/pixmaps
	[ -e ${MOD_ICON} ] && doins ${MOD_ICON}

	prepgamesdirs
	make_desktop_entry ${MOD_BINS} "UT2004 - ${MOD_NAME}" ${MOD_ICON}
}

games-ut2k4mod_pkg_postinst() {

	einfo "To play this mod run:"
	einfo " ${MOD_BINS}"

	games_pkg_postinst
}
