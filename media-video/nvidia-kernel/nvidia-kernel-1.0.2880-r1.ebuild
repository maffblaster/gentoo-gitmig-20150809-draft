# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer:  Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/nvidia-kernel/nvidia-kernel-1.0.2880-r1.ebuild,v 1.4 2002/05/08 05:00:56 jnelson Exp $

DESCRIPTION="Linux kernel module for the NVIDIA's X driver"
HOMEPAGE="http://www.nvidia.com/"

NV_V=${PV/1.0./1.0-}
NV_PACKAGE=NVIDIA_kernel-${NV_V}
S="${WORKDIR}/${NV_PACKAGE}"
SRC_URI="ftp://download.nvidia.com/XFree86_40/${NV_V}/${NV_PACKAGE}.tar.gz
	http://download.nvidia.com/XFree86_40/${NV_V}/${NV_PACKAGE}.tar.gz"

DEPEND="virtual/linux-sources
	>=sys-apps/portage-1.9.4"

# Make sure Portage does _NOT_ strip symbols.  Need both lines for
# Portage 1.8.9+
DEBUG="yes"
RESTRICT="nostrip"

src_compile() {
	# Portage should determine the version of the kernel sources
	if [ x"${KV}" = x ]
	then
		eerror ""
		eerror "Could not determine you kernel version."
		eerror "Make sure that you have /usr/src/linux symlink."
		eerror ""
		die
	fi
	make KERNDIR="/usr/src/linux" \
		clean NVdriver || die
}

src_install () {
	# The driver goes into the standard modules location
	insinto "/lib/modules/${KV}/kernel/video"
	doins NVdriver
    
	# Add the aliases
	insinto /etc/modules.d
	doins "${FILESDIR}"/nvidia

	# Docs
	dodoc ${S}/README

	# The device creation script
	into /
	newsbin ${S}/makedevices.sh NVmakedevices.sh
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ]
	then
		# Get any stale module unloaded
		[ -x /sbin/rmmod ]              && /sbin/rmmod NVdriver
		# Update module dependency
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
		# Load the module again
		[ -x /sbin/modprobe ]           && /sbin/modprobe NVdriver
		if [ ! -e /dev/.devfsd ] && [ -x /sbin/NVmakedevices.sh ]
		then
			/sbin/NVmakedevices.sh >/dev/null 2>&1
		fi
	fi

	einfo
	einfo "If you are not using devfs, you might want to create nvidia"
	einfo "device nodes by running /sbin/NVmakedevices.sh"
	einfo
	einfo "To load the module automatically at boot up, add"
	einfo "\"NVdriver\" to your /etc/modules.autoload:"
	einfo
}

