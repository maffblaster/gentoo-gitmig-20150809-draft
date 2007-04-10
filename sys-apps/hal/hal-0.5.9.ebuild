# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hal/hal-0.5.9.ebuild,v 1.13 2007/04/10 00:38:16 cardoe Exp $

inherit eutils linux-info autotools flag-o-matic

DESCRIPTION="Hardware Abstraction Layer"
HOMEPAGE="http://www.freedesktop.org/Software/hal"
SRC_URI="http://people.freedesktop.org/~david/dist/${P}.tar.gz"

LICENSE="|| ( GPL-2 AFL-2.0 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 -mips ~ppc ~ppc64 ~sh ~sparc ~x86"

KERNEL_IUSE="kernel_linux kernel_FreeBSD"
IUSE="acpi crypt debug dell disk-partition doc pam pcmcia selinux ${KERNEL_IUSE}"

RDEPEND=">=dev-libs/glib-2.6
		>=dev-libs/dbus-glib-0.61
		kernel_linux? ( >=sys-fs/udev-104 )
		kernel_linux? ( >=sys-apps/util-linux-2.12r-r1 )
		kernel_linux? ( >=sys-kernel/linux-headers-2.6.17 )
		kernel_FreeBSD? ( dev-libs/libvolume_id )
		>=dev-libs/expat-1.95.8
		>=sys-apps/pciutils-2.2.3
		>=dev-libs/libusb-0.1.10a
		virtual/eject
		amd64? ( >=sys-apps/dmidecode-2.7 )
		x86? ( >=sys-apps/dmidecode-2.7 )
		ia64? ( >=sys-apps/dmidecode-2.7 )
		dell? ( >=sys-libs/libsmbios-0.13.4 )
		disk-partition? ( >=sys-apps/parted-1.7.1 )
		crypt? ( >=sys-fs/cryptsetup-luks-1.0.1 )
		selinux? ( sys-libs/libselinux
					sec-policy/selinux-hal )
		pam? ( sys-auth/consolekit )"

DEPEND="${RDEPEND}
		  dev-util/pkgconfig
		>=dev-util/intltool-0.35
		doc? ( app-doc/doxygen app-text/docbook-sgml-utils )"

PDEPEND="app-misc/hal-info"

## HAL Daemon drops privledges so we need group access to read disks
HALDAEMON_GROUPS="haldaemon,plugdev,disk,cdrom,cdrw,floppy,usb"

function notify_uevent() {
	ewarn
	ewarn "You must enable Kernel Userspace Events in your kernel."
	ewarn "For this you need to enable 'Hotplug' under 'General Setup' and"
	ewarn "basic networking.  They are marked CONFIG_HOTPLUG and CONFIG_NET"
	ewarn "in the config file."
	ewarn
	ebeep 5
}

function notify_procfs() {
	ewarn
	ewarn "You must enable the proc filesystem in your kernel."
	ewarn "For this you need to enable '/proc file system support' under"
	ewarn "'Pseudo filesystems' in 'File systems'.  It is marked"
	ewarn "CONFIG_PROC_FS in the config file."
	ewarn
	ebeep 5
}

function notify_inotify() {
	ewarn
	ewarn "You must enable the Inotify system in your kernel."
	ewarn "For this you need to enable 'Inotify support for userspace'"
	ewarn "in 'File systems'. It is marked CONFIG_INOTIFY_USER in the config file."
	ewarn
	ebeep 5
}

pkg_setup() {
	kernel_is ge 2 6 17 || ewarn "HAL requires a kernel version 2.6.17 or newer"

	if ! ( linux_chkconfig_present HOTPLUG && linux_chkconfig_present NET )
	then
		notify_uevent
	fi

	linux_chkconfig_present INOTIFY_USER || notify_inotify

	if use acpi ; then
		linux_chkconfig_present PROC_FS || notify_procfs
	fi

	if [[ -d ${ROOT}/etc/hal/device.d ]]; then
		eerror "HAL 0.5.x will not run with the HAL 0.4.x series of"
		eerror "/etc/hal/device.d/ so please remove this directory"
		eerror "with rm -rf /etc/hal/device.d/ and then re-emerge."
		eerror "This is due to configuration protection of /etc/"
		die "remove /etc/hal/device.d/"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Gentoo Patch Set
	EPATCH_SUFFIX="patch" EPATCH_FORCE="yes" epatch ${FILESDIR}/${PV}
}

src_compile() {
	local backend=""
	local acpi=""

	# TODO :: policykit should have a pam useflag
	append-flags -rdynamic

	if use kernel_linux ; then
		backend="linux"
	elif use kernel_FreeBSD ; then
		backend="freebsd"
	else
		eerror "Invalid backend"
	fi

	if use acpi ; then
		acpi="--enable-acpi-toshiba --enable-acpi-ibm"
	else
		acpi="--disable-acpi-proc --disable-acpi-acpid"
	fi

	econf --disable-policy-kit \
		  --with-doc-dir=/usr/share/doc/${PF} \
		  --with-os-type=gentoo \
		  --with-pid-file=/var/run/hald.pid \
		  --with-hwdata=/usr/share/misc \
		  --enable-hotplug-map \
		  --enable-man-pages \
		  --with-backend=${backend} \
		  $(use_enable debug verbose-mode) \
		  $(use_with dell dell-backlight) \
		  $(use_enable disk-partition parted) \
		  $(use_enable pcmcia pcmcia-support) \
		  $(use_enable doc docbook-docs) \
		  $(use_enable doc doxygen-docs) \
		  $(use_enable selinux) \
		  $(use_enable pam console-kit) \
		  ${acpi} \
	|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README

	# remove dep on gnome-python
	mv "${D}"/usr/bin/hal-device-manager "${D}"/usr/share/hal/device-manager/

	# hal umount for unclean unmounts
	exeinto /lib/udev/
	newexe "${FILESDIR}"/hal-unmount.dev hal_unmount

	# initscript
	newinitd "${FILESDIR}"/0.5.9-hald.rc hald
	newconfd "${FILESDIR}"/0.5.9-hald.conf hald
	if use pam; then
		sed -e 's:RC_NEED:RC_NEED="consolekit":' -i /etc/conf.d/hald
	else
		sed -e 's:RC_NEED:RC_NEED="":' -i /etc/conf.d/hald
	fi

	# We now create and keep /media here as both gnome-mount and pmount
	# use these directories, to avoid collision.
	keepdir /media

	# We also need to create and keep /etc/fdi/{information,policy,preprobe}
	# or else hal bombs.
	keepdir /etc/hal/fdi/{information,policy,preprobe}

	# HAL stores it's fdi cache in /var/lib/cache/hald
	keepdir /var/lib/cache/hald
}

pkg_postinst() {
	# Despite what people keep changing this location. Either one works.. it doesn't matter
	# http://dev.gentoo.org/~plasmaroo/devmanual/ebuild-writing/functions/

	# Create groups for hotplugging and HAL
	enewgroup haldaemon || die "Problem adding haldaemon group"
	enewgroup plugdev || die "Problem adding plugdev group"

	# HAL drops priviledges by default now ...
	# ... so we must make sure it can read disk/cdrom info (ie. be in ${HALDAEMON_GROUPS} groups)
	enewuser haldaemon -1 "-1" /dev/null ${HALDAEMON_GROUPS} || die "Problem adding haldaemon user"

	# Make sure that the haldaemon user is in the ${HALDAEMON_GROUPS}
	# If users have a problem with this, let them file a bug
	usermod -G ${HALDAEMON_GROUPS} haldaemon

	elog "The HAL daemon needs to be running for certain applications to"
	elog "work. Suggested is to add the init script to your start-up"
	elog "scripts, this should be done like this :"
	elog "\`rc-update add hald default\`"
	echo
	elog "Looking for automounting support? Add yourself to the plugdev group"
}
