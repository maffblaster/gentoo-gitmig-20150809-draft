# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/maya/maya-6.0.ebuild,v 1.3 2004/06/19 20:54:42 eradicator Exp $

# Note that this ebuild requires you to set the MAYA_INSTALL_LOC environment
# variable to the location of your maya RPMS and documentation:
# MAYA_INSTALL_LOC=/mnt/cdrom/LINUX is default
#
# This directory should contain something files that look like this:
# -r--r--r--    1 nobody   cdrom     1299763 Apr 13 11:08 AWCommon-6.0-1.i686.rpm
# -r--r--r--    1 nobody   cdrom      389544 Apr 13 11:08 AWCommon-server-6.0-1.i686.rpm
# dr-xr-xr-x    2 nobody   cdrom        2048 Apr 13 11:09 License_Support
# -r--r--r--    1 nobody   cdrom    96007715 Apr 13 11:08 Maya6_0-6.0-116.i686.rpm
# -r--r--r--    1 nobody   cdrom       28232 Apr 13 11:09 README.html
# dr-xr-xr-x    2 nobody   cdrom        2048 May 12 07:58 crack
# dr-xr-xr-x    3 nobody   cdrom        2048 Apr 13 11:09 documentation
# -r-xr-xr-x    1 nobody   cdrom        2425 Apr 13 11:08 installDocs.sh
# dr-xr-xr-x    3 nobody   cdrom        2048 Apr 13 11:09 support

inherit rpm eutils

IUSE="bundled-libs"
S="${WORKDIR}"

DESCRIPTION="Alias Wavefront's Maya.  Comercial modeling and animation package."
HOMEPAGE="http://www.alias.com/eng/products-services/maya/index.shtml"

# Patches to download go into SRC_URI
#SRC_URI="myr_maya501_gold_linux_update.tgz myr_TechDocs.zip"
SRC_URI=""
RESTRICT="fetch nouserpriv"

# RPM versions within the tarballs which will get installed
AWCOMMON="6.0-1.i686"
AWCOMMON_SERVER="6.0-1.i686"
MAYA6_0="6.0-116.i686"

SLOT="6.0"

LICENSE="maya-5.0 mayadoc-5.0"
# Still having trouble getting the docs working right.
KEYWORDS="-x86 -amd64"

DEPEND="app-arch/unzip"

RDEPEND="|| ( app-shells/tcsh app-shells/csh )
	 x86? ( >=sys-libs/lib-compat-1.3
	        !bundled-libs? ( =x11-libs/qt-3*
	                         >=sys-devel/gcc-3*
	                         >=x11-libs/openmotif-2.1.30 ) )
	 amd64? ( app-emulation/emul-linux-x86-baselibs
	          app-emulation/emul-linux-x86-xlibs
	          app-emulation/emul-linux-x86-qtlibs )
	 virtual/jre
	 virtual/opengl"

pkg_nofetch() {
#	einfo "Please place the required files and place them in ${DISTDIR}:"
#	einfo
#	einfo "Downloads from Alias's support server:"
#	einfo "http://aliaswavefront.topdownloads.com/pub/bws/bws_107/myr_maya501_gold_linux_update.tgz"
#	einfo "http://aliaswavefront.topdownloads.com/pub/bws/bws_79/myr_TechDocs.zip"
#	einfo
	einfo "You need to place the Maya 6 CD in the CD drive (we expect /mnt/cdrom)."
	einfo "If you don't use /mnt/cdrom or you have network installation files, then you need to set"
	einfo "the environment variable 'MAYA_INSTALL_LOC' to the directory containing AWCommon-6.0-1.i686.rpm,"
	einfo "AWCommon-server-6.0-1.i686.rpm, Maya6_0-6.0-116.i686.rpm, and documentation."
	einfo
}

src_unpack() {
	einfo ${MAYA_INSTALL_LOC}
	if [ -z "${MAYA_INSTALL_LOC}" ]; then
		cdrom_get_cds LINUX/AWCommon-${AWCOMMON}.rpm
		MAYA_INSTALL_LOC=${CDROM_ROOT}/LINUX
	fi

	if [ ! -d "${MAYA_INSTALL_LOC}" ]; then
		eerror "MAYA_INSTALL_LOC is not set to a valid location.  ${MAYA_INSTALL_LOC} is not a directory."
		die "Failure finding maya install files."
	fi

	cd ${MAYA_INSTALL_LOC}
	ebegin "Checking md5sum of files in ${MAYA_INSTALL_LOC}"
	md5sum -c ${FILESDIR}/${P}.md5sum
	if [ $? -ne 0 ]; then
		eend 1
		die "Failure checking md5sum of files in ${MAYA_INSTALL_LOC}.  If you are certain your CD is not corrupt, file a bug at http://bugs.gentoo.org, comment out the md5sum checking in the ebuild, and proceed at your own risk."
	fi
	eend 0

	mkdir ${S}/RPMS
	cd ${S}/RPMS
	# Unpack downloaded tarballs containing RPMs
	# unpack myr_maya501_gold_linux_update.tgz

	# rpm_unpack unpacks in ${WORKDIR} no matter what we try... so get it out of the way...
	cd ${S}
	rpm_unpack ${MAYA_INSTALL_LOC}/AWCommon-${AWCOMMON}.rpm
	rpm_unpack ${MAYA_INSTALL_LOC}/AWCommon-server-${AWCOMMON_SERVER}.rpm
	rpm_unpack ${MAYA_INSTALL_LOC}/Maya6_0-${MAYA6_0}.rpm

	# Unpack updated RPMs
	# rpm_unpack ${S}/RPMS/Maya5_0-${MAYA5_0}.rpm

	mkdir ${S}/insroot
	mv ${S}/usr ${S}/insroot

	# Don't need their init script
	rm -rf etc

	cp -a ${MAYA_INSTALL_LOC}/documentation ${MAYA_INSTALL_LOC}/README.html ${S}

	# Remove unneeded libs (provided by DEPEND).
	if ! use bundled-libs; then
		rm -f ${S}/insroot/usr/aw/COM/lib/libXm.so.2.1
		rm -f ${S}/insroot/usr/aw/maya6.0/lib/libgcc_s.so.1
		rm -f ${S}/insroot/usr/aw/maya6.0/lib/libstdc++.so.5.0.5

		# We keep this one because of possible C++ ABI changes...
		# Maya 6 was compiled with gcc 3.0
		# rm -f ${S}/insroot/usr/aw/maya6.0/lib/libqt.so.3

		rm -f ${S}/insroot/usr/aw/maya6.0/lib/libXm.so.2

		# Use our own jre... chmod first as it might be RO from being on CD
		chmod 755 ${S}/documentation/Linux_MayaDocs_Installer/Linux_installMayaDocServer.bin
		sed -i 's:^\(JRESTART=.*\)$:#\1:' ${S}/documentation/Linux_MayaDocs_Installer/Linux_installMayaDocServer.bin
	fi

	# Documentation update
	# mkdir ${S}/docs.upgrade
	# cd ${S}/docs.upgrade
	# unpack myr_TechDocs.zip
}

src_install() {
	dohtml README.html

	cd ${S}/insroot
	cp -a . ${D}

	# What follows is modified from rpm -qp --scripts RPMS/AWCommon-5.3-5.i686.rpm
	for lmexec in lmcksum lmdiag lmdown lmhostid lmremove lmreread lmstat lmver; do
		dosym lmutil /usr/aw/COM/bin/${lmexec}
	done

	# We use our own Motif runtime unless USE=bundled-libs
	if use bundled-libs; then
		dosym libXm.so.2.1 libXm.so
		dosym libXm.so.2.1 libXm.so.2
	fi

	dosym COM /usr/aw/COM2
	# End rpm -qp --scripts RPMS/AWCommon-5.3-5.i686.rpm

	# What follows is modified from rpm -qp --scripts RPMS/Maya5_0-5.0.1-135.i686.rpm
	keepdir /var/flexlm
	fperms ugo+w /var/flexlm

	dosym maya6.0 /usr/aw/maya

	# The RPM puts these in /usr/local/bin
	keepdir /usr/bin
	dosym /usr/aw/maya6.0/bin/Maya6.0 /usr/aw/maya6.0/bin/maya
	for mayaexec in Render fcheck imgcvt maya; do
		dosym /usr/aw/maya6.0/bin/${mayaexec} /usr/bin/${mayaexec}
	done

	dosym Mayatomr.so /usr/aw/maya6.0/bin/plug-ins/Mayatomr.sog

	# We use our own gcc3 runtime unless USE=bundled-libs
	if use bundled-libs; then
		dosym libgcc_s.so.1 /usr/aw/maya6.0/lib/libgcc_s.so
		dosym libstdc++.so.5.0.5 /usr/aw/maya6.0/lib/libstdc++.so.5
		dosym libstdc++.so.5.0.5 /usr/aw/maya6.0/lib/libstdc++.so
	fi

	# update the mental ray configuration files in place
	dosed "/\[PREFIX\]/s//\/usr/" /usr/aw/maya6.0/mentalray/maya.rayrc
	dosed "/\[PREFIX\]/s//\/usr/" /usr/aw/maya6.0/bin/mayarender_with_mr
	dosed "/\[PREFIX\]/s//\/usr/" /usr/aw/maya6.0/bin/mentalrayrender
	dosed "/\[PREFIX\]/s//\/usr/" /usr/aw/maya6.0/bin/mayaexport_with_mr
	fperms 755 /usr/aw/maya6.0/bin/mayarender_with_mr /usr/aw/maya6.0/bin/mentalrayrender

	# links for pcw
	dosym /usr/aw/maya6.0/lib/libawcsprt.so.1 /usr/aw/maya6.0/lib/libawcsprt.so
	dosym /usr/aw/maya6.0/lib/libpcw_opa.so.1 /usr/aw/maya6.0/lib/libpcw_opa.so
	dosym /usr/aw/maya6.0/lib/libpcwfindkey.so.1 /usr/aw/maya6.0/lib/libpcwfindkey.so
	dosym /usr/aw/maya6.0/lib/libpcwxml.so.1 /usr/aw/maya6.0/lib/libpcwxml.so

	# End rpm -qp --scripts RPMS/Maya5_0-5.0.1-135.i686.rpm

	exeinto /etc/init.d
	doexe ${FILESDIR}/maya-docs ${FILESDIR}/aw_flexlm

	insinto /etc/conf.d
	newins ${FILESDIR}/aw_flexlm.conf.d aw_flexlm

	# Now for the docs stuff...
	cd ${S}/documentation
	addpredict /var/.com.zerog.registry.lock
	addwrite /var/.com.zerog.registry.xml
	einfo "Starting Maya 6.0 DocServer installation..."
	./Linux_MayaDocs_Installer/Linux_installMayaDocServer.bin -DUSER_INSTALL_DIR="${D}/usr/aw/maya6.0/docs" -i silent
	# ./Linux_Maya50Docs_Installer/installMayaDocServer.bin -DUSER_INSTALL_DIR="${D}/usr/aw/maya6.0/docs" -i silent
	# einfo "Starting Maya 6.0 English Documentation installation..."
	# ./Linux_M5en_US_Installer/install_en_US_docs.bin -DUSER_INSTALL_DIR="${D}/usr/aw/maya6.0/docs/Documents" -i silent

	# And now the doc update
	# cd ${S}/docs.upgrade
	# insinto /usr/aw/maya6.0/docs/Documents/Maya6.0/en_US
	# doins *.zip

	# cd ${S}/docs.upgrade/style
	# insinto /usr/aw/maya6.0/docs/Documents/Maya6.0/en_US/style
	# doins *

	# Fix permissions
	find ${D}/usr/aw -type d -exec chmod 755 {} \;
}

pkg_postinst() {
	# What follows is modified from rpm -qp --scripts RPMS/Maya5_0-5.0.1-135.i686.rpm
	cp /etc/services /tmp/services.maya_save
	awk '/mi-ray3_2maya5_0/ { found++; print ; next } {print} END {if (0==found) print "mi-ray3_2maya5_0 7054/tcp" }' /tmp/services.maya_save > /etc/service

	# update the magic file 
	if [ -e /usr/share/magic ]; then
		mv /usr/share/magic /tmp/magic.rpmsave
		awk '/Alias.Wavefront Maya files. begin/ {p=1} /Alias.Wavefront Maya files. end/ {p=2} {if (p==2) { p=0} else if (p==0) print }' /tmp/magic.rpmsave > /usr/share/magic
		cat /usr/aw/maya6.0/.tmpdata/awmagic >> /usr/share/magic;
		# get file to rebuild the cache 
		file -C > /dev/null 2>&1
		rm -Rf /usr/aw/maya6.0/.tmpdata/awmagic 2>&1 > /dev/null
	fi
	# End rpm -qp --scripts RPMS/Maya5_0-5.0.1-135.i686.rpm

	einfo "There may be a more recent license for this workstation available on the Alias|Wavefront"
	einfo "web site. Please visit the following URL to check for updated licenses:"
	einfo "http://www.aliaswavefront.com/en/Community/Special/keys/maya/"
	einfo
	einfo "To install your key, either place aw.dat in /var/flexlm or run the following command from an X session:"
	einfo "/usr/aw/COM/bin/installKey -input /usr/aw/maya6.0/license_data/maya_prekey_data"
	einfo
	einfo "Two init scripts have been installed:"
	einfo "maya-docs is for the document server (help system)."
	einfo "aw_flexlm is for the license server"
	einfo

	einfo "Maya 6.0 was compiled with gcc 3.0 and origionally linked against glibc 2.1.3.  If you intend to compile"
	einfo "plugins for Maya, you will need to 'emerge \=sys-devel/gcc-3.0*' and use gcc-config to switch compilers."
	einfo "The Maya SDK headers are located in /usr/aw/maya/include, and libs are in /usr/aw/maya/lib."
	einfo

	# http://www.highend2d.com/boards/showthreaded.php?Cat=&Board=linuxforum&Number=174726&page=&view=&sb=&o=
	ewarn "You should disable klipper, xfce4-clipman, and any other clipboard"
	ewarn "utilities as they have been shown to cause maya-5.0.1 to crash."
	ewarn "Feedback on whether or not this is still true ion Maya 6 would be"
	ewarn "appreciated at http://bugs.gentoo.org"
}
