# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/vim.eclass,v 1.18 2003/03/27 04:28:14 agriffis Exp $

# Authors:
# 	Ryan Phillips <rphillips@gentoo.org>
# 	Seemant Kulleen <seemant@gentoo.org>
# 	Aron Griffis <agriffis@gentoo.org>

ECLASS=vim
EXPORT_FUNCTIONS src_unpack

inherit eutils

#==========================================================================
# Please note:
#
# The SRC_URI is determined in the following code via bash
# conditionals.  Normally this is not allowed, because SRC_URI (also
# DEPEND/RDEPEND) are cached on Angel, and this cache is used by users
# that get portage via rsync.  If bash conditionals can change the
# output of SRC_URI/DEPEND/RDEPEND based on some variable (such as
# USE), then the cache becomes invalid.
#
# So the reason the following code is valid is that the bash
# conditionals aren't testing something *variable*.  I.e. the only
# thing being tested is the version, which won't change from machine
# to machine, so the cache remains valid.
#
# (21 Mar 2003 agriffis)
#==========================================================================

# Calculate the version based on the name of the ebuild, for example
# (these examples are old but still applicable for the naming scheme)
#   vim-6.0, when 6.0 is finally released
#   vim-6.0_pre9, where 9 = (i), for vim-6.0i
#   vim-6.0_pre47, where 47 = 26(a) + 21(u), for vim-6.0au
#   vim-6.0_pre72, where 72 = 52(b) + 20(t), for vim-6.0bt
vim_version="${PV%_pre*}"
vim_pre="${PV##*_pre}"

if [ "${vim_version}" = "${vim_pre}" ]; then
	# Final releases prior to 6.0 include a dash and decimal point in
	# the directory name
	if [ "${vim_version%%.*}" -lt 6 ]; then
		S="$WORKDIR/vim-${vim_version}"
	else
		S="$WORKDIR/vim${vim_version//.}"
	fi
	vim_letters=
	MY_P="vim-${vim_version}"
	SRC_URI="ftp://ftp.vim.org/pub/vim/unix/${MY_P}.tar.bz2
		ftp://ftp.us.vim.org/pub/vim/unix/${MY_P}.tar.bz2"
#		ftp://ftp.vim.org/pub/vim/extra/${MY_P}-extra.tar.gz"

elif [ "${vim_pre}" -lt 27 ]; then
	# Handle (prerelease) versions with one trailing letter
	vim_letters=`echo ${vim_pre} | awk '{printf "%c", $0+96}'`
	S="$WORKDIR/vim${vim_version//.}${vim_letters}"
	MY_P="vim-${vim_version}${vim_letters}"
	SRC_URI="ftp://ftp.vim.org/pub/vim/unreleased/unix/${MY_P}.tar.bz2
		ftp://ftp.us.vim.org/pub/vim/unreleased/unix/${MY_P}.tar.bz2"
#		ftp://ftp.vim.org/pub/vim/extra/${MY_P}-extra.tar.gz"

elif [ "${vim_pre}" -lt 703 ]; then
	# Handle (prerelease) versions with two trailing letters
	vim_letters=`echo ${vim_pre} | awk '{printf "%c%c", $0/26+96, $0%26+96}'`
	S="$WORKDIR/vim${vim_version//.}${vim_letters}"
	MY_P="vim-${vim_version}${vim_letters}"
	SRC_URI="ftp://ftp.vim.org/pub/vim/unreleased/unix/${MY_P}.tar.bz2
		ftp://ftp.us.vim.org/pub/vim/unreleased/unix/${MY_P}.tar.bz2"
#		ftp://ftp.vim.org/pub/vim/extra/${MY_P}-extra.tar.gz"

else
	die "Eek!  I don't know how to interpret the version!"
fi

# Add Vim NLS sources
SRC_URI="${SRC_URI} 
	nls? ( ftp://ftp.vim.org/pub/vim/extra/vim-${vim_version}-lang.tar.gz )"

# VIMPATCH is set in the actual vim/gvim ebuild.  These are the
# incremental patches released by Bram.
[ -n "${VIMPATCH}" ] && \
SRC_URI="${SRC_URI} mirror://gentoo/vim-${PV}-patches-001-${VIMPATCH}.tar.bz2"

# Bug #18134 is interesting... All the ebuilds in the tree have
# VIMPATCH=numeric.  However there are installed instances of vim that
# will read the eclass when they uninstall, in which
# VIMPATCH=full_patch_name.  So test for that here (in which case we
# just skip the additon to SRC_URI because it really doesn't matter).
case ${VIMPATCH} in
	vim*) ;; # Unmerging an old ebuild ...
	*)       # Normal operation

	# Various patches from RH, etc.
	# Started versioning this tarball when VIMPATCH hit 411
	if [ "${VIMPATCH:-0}" -ge 411 ]; then
		SRC_URI="${SRC_URI} 
			mirror://gentoo/vim-${PV}-${VIMPATCH}-gentoo-patches.tar.bz2"
	else
		SRC_URI="${SRC_URI} mirror://gentoo/vim-${PV}-gentoo-patches.tar.bz2"
	fi 
	
	;;
esac

#=== End of SRC_URI setting ===============================================

HOMEPAGE="http://www.vim.org/"
SLOT="0"
LICENSE="vim"

apply_vim_patches() {
	einfo "Applying various patches (bugfixes/updates)..."

	local p

	# Remove patches specifically excluded in the ebuild;
	# note this approach is deprecated since now the patch scanner
	# below does all the work.
	for p in ${EXCLUDE_PATCH}; do
		rm -f ${WORKDIR}/vimpatches/${PV}.$p.gz
	done

	# Scan the patches, applying them only to files that either
	# already exist or that will be created by the patch
	for p in ${WORKDIR}/vimpatches/${vim_version}.*.gz; do
		gzip -dc ${p} | awk '
			$1=="---" && $NF~/^200.$/ {
				# Second line of a new patch; try to open the file to see
				# if it exists.
				if ((getline tryme < $2) == -1) {
					# Check if it will be created
					prevline = prevline "\n" $0
					getline
					prevline = prevline "\n" $0
					getline
					if ($0 != "*** 0 ****") {
						# Non-existent and not created, stop printing
						printing = 0
						next
					}
				}
				# Print the previous lines and continue
				print prevline
				printing = 1
			}
			printing { print }
			{ prevline = $0 }' > ${p%.gz} || die

		# Apply the patch now that it's filtered
		[ -s ${p%.gz} ] && epatch ${p%.gz}

		# Conserve disk space
		rm -f ${p%.gz}
	done
}

vim_src_unpack() {
	unpack ${A}

	# Apply any patches available for this version
	cd ${S}
	apply_vim_patches

	# Fixup a script to use awk instead of nawk
	cd ${S}/runtime/tools
	mv mve.awk mve.awk.old
	( read l; echo "#!/usr/bin/awk -f"; cat ) <mve.awk.old >mve.awk || die

	# Another set of patch's borrowed from src rpm to fix syntax error's etc.
	cd ${S}
	EPATCH_SUFFIX="gz" \
		EPATCH_FORCE="yes" \
		epatch ${WORKDIR}/gentoo/patches-all/
}

src_compile() {
	local myconf

	if [ ${PN} = vim-core ]; then
		myconf="--with-features=tiny \
			--enable-gui=no \
			--without-x \
			--disable-perlinterp \
			--disable-pythoninterp \
			--disable-rubyinterp \
			--disable-gpm"

		use nls \
			&& myconf="${myconf} --enable-multibyte" \
			|| myconf="${myconf} --disable-nls"
	else
		myconf="--with-features=huge \
			--enable-multibyte \
			--enable-cscope"
		myconf="${myconf} `use_enable nls`"
		myconf="${myconf} `use_enable gpm`"
		myconf="${myconf} `use_enable perl perlinterp`"
		myconf="${myconf} `use_enable python pythoninterp`"
		myconf="${myconf} `use_enable ruby rubyinterp`"

		# tclinterp is broken; when you --enable-tclinterp flag, then
		# the following command never returns:
		#   VIMINIT='let OS=system("uname -s")' vim
		#myconf="${myconf} `use_enable tcl tclinterp`"

		# The console vim will change the caption of a terminal in X.
		# Disable this functionality unless USE=X.  Don't use
		# "use_with" here because then we're telling Vim to use X even
		# though it might not be installed.
		if [ ${PN} = vim ]; then
			use X || myconf="${myconf} --without-x"
		fi
	fi

	# This should fix a sandbox violation.
	for file in /dev/pty/s*; do
		addwrite $file
	done


	if [ "${PN}" = "gvim" ]; then
		myconf="${myconf} --with-vim-name=gvim --with-x"
		if use gtk2; then
			myconf="${myconf} --enable-gui=gtk2 --enable-gtk2-check"
		elif use gnome; then
			myconf="${myconf} --enable-gui=gnome"
		elif use gtk; then
			myconf="${myconf} --enable-gui=gtk"
		else
			myconf="${myconf} --enable-gui=athena"
		fi
	else
		myconf="${myconf} --enable-gui=no"
	fi

	econf ${myconf} || die "vim configure failed"

	if [ "${PN}" = "vim-core" ]
	then
		make tools || die "vim make failed"
		cd ${S}
		rm src/vim
	else
		# move config files to /etc/vim/
		echo "#define SYS_VIMRC_FILE \"/etc/vim/vimrc\"" \
			>>${WORKDIR}/vim61/src/feature.h
		echo "#define SYS_GVIMRC_FILE \"/etc/vim/gvimrc\"" \
			>>${WORKDIR}/vim61/src/feature.h

		# Parallel make does not work
		make || die "vim make failed"
	fi
}

src_install() {
	if [ "${PN}" = "vim-core" ]; then
		dodir /usr/{bin,share/{man/man1,vim}}
		cd src
		make \
			installruntime \
			installhelplinks \
			installmacros \
			installtutor \
			installtools \
			install-languages \
			install-icons \
			DESTDIR=${D} \
			BINDIR=/usr/bin \
			MANDIR=/usr/share/man \
			DATADIR=/usr/share \
			|| die "install failed"

		dodoc README*
		cd $D/usr/share/doc/$PF
		ln -s ../../vim/*/doc $P

		keepdir /usr/share/vim/vim${vim_version/.}/keymap

		# fix problems with vim not finding its data files.
		echo "VIMRUNTIME=/usr/share/vim/vim${vim_version/.}" > 40vim
		insinto /etc/env.d
		doins 40vim

		# default vimrc is installed by vim-core since it applies to
		# both vim and gvim
		insinto /etc/vim/
		doins ${FILESDIR}/vimrc
	elif [ "${PN}" = "gvim" ]; then
		dobin src/gvim
		dosym gvim /usr/bin/gvimdiff
		insinto /etc/vim
		doins ${FILESDIR}/gvimrc
	else
		dobin src/vim
		ln -s vim ${D}/usr/bin/vimdiff
		ln -s vim ${D}/usr/bin/rvim
		ln -s vim  ${D}/usr/bin/ex
		ln -s vim  ${D}/usr/bin/view
		ln -s vim  ${D}/usr/bin/rview
	fi
}

pkg_postinst() {
	einfo
	if [ ${PN} = gvim ]; then
		einfo "To enable UTF-8 viewing, set guifont and guifontwide: "
		einfo ":set guifont=-misc-fixed-medium-r-normal-*-18-120-100-100-c-90-iso10646-1"
		einfo ":set guifontwide=-misc-fixed-medium-r-normal-*-18-120-100-100-c-180-iso10646-1"
		einfo
		einfo "note: to find out which fonts you can use, please read the UTF-8 help:"
		einfo ":h utf-8"
		einfo
		einfo "Then, set read encoding to UTF-8:"
		einfo ":set encoding=utf-8"
	elif [ ${PN} = vim ]; then
		einfo "gvim has now a seperate ebuild, 'emerge gvim' will install gvim"
	fi
	einfo

	# Make convenience symlinks, hopefully without stepping on toes
	[ -f /usr/bin/gvim ] && ln -s gvim /usr/bin/vim 2>/dev/null
	[ -f /usr/bin/vim ] && ln -s vim /usr/bin/vi 2>/dev/null
}
