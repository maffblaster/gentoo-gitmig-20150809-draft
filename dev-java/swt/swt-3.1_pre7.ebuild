# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/swt/swt-3.1_pre7.ebuild,v 1.3 2005/07/06 03:19:17 compnerd Exp $

inherit eutils java-pkg

MY_DMF="S-3.1M7-200505131415"
MY_VERSION="3.1M7"

DESCRIPTION="GTK based SWT Library"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="x86? ( http://download.eclipse.org/downloads/drops/${MY_DMF}/swt-${MY_VERSION}-gtk-linux-x86.zip )
		 amd64? ( http://download.eclipse.org/downloads/drops/${MY_DMF}/swt-${MY_VERSION}-gtk-linux-x86_64.zip )
		 ppc? ( http://download.eclipse.org/downloads/drops/${MY_DMF}/swt-${MY_VERSION}-gtk-linux-ppc.zip )"

SLOT="3"
LICENSE="CPL-1.0 LGPL-2.1 MPL-1.1"
KEYWORDS="~x86 ~amd64 ~ppc"

IUSE="accessibility cairo firefox gnome mozilla"
DEPEND="${RDEPEND}
		>=virtual/jdk-1.4
		  dev-java/ant-core
		  app-arch/unzip"
RDEPEND=">=virtual/jre-1.4
		 mozilla? (
		 			 firefox? ( >=www-client/mozilla-firefox-1.0.3 )
					!firefox? ( >=www-client/mozilla-1.4 )
				  )
		 gnome? ( =gnome-base/gnome-vfs-2* =gnome-base/libgnomeui-2* )
		 cairo? ( >=x11-libs/cairo-0.3.0 )"

S=${WORKDIR}

pkg_setup() {
	if use firefox ; then
		if ! use mozilla ; then
			echo
			ewarn "You must enable the mozilla useflag to build the browser"
			ewarn "component.  The firefox flag is used only to determine"
			ewarn "what to build against."

			die "Firefox useflag enabled without mozilla support"
		fi
	fi
}

src_unpack() {
	# Extract based on architecture
	if [[ ${ARCH} == 'amd64' ]] ; then
		unpack swt-${MY_VERSION}-gtk-linux-x86_64.zip
	elif [[ ${ARCH} == 'ppc' ]] ; then
		unpack swt-${MY_VERSION}-gtk-linux-ppc.zip
	else
		unpack swt-${MY_VERSION}-gtk-linux-x86.zip
	fi

	# Clean up the directory structure
	rm -r *.so swt.jar
	rm -rf about_files/

	# Unpack the sources
	einfo "Unpacking src.zip to ${S}"
	unzip src.zip &> /dev/null || die "Unable to extract sources"

	# Replace the build.xml to allow compilation without Eclipse tasks
	cp ${FILESDIR}/build-${PV}.xml ${S}/build.xml || die "Unable to update build.xml"
	mkdir ${S}/src && mv ${S}/org ${S}/src || die "Unable to restructure SWT sources"
}

src_compile() {
	JAVA_HOME=$(java-config -O)

	# Identify the AWT path
	if [[ ! -z "$(java-config --java-version | grep 'IBM')" ]] ; then
		export AWT_LIB_PATH=$JAVA_HOME/jre/bin
	else
		if [[ ${ARCH} == 'x86' ]] ; then
			export AWT_LIB_PATH=$JAVA_HOME/jre/lib/i386
		elif [[ ${ARCH} == 'ppc' ]] ; then
			export AWT_LIB_PATH=$JAVA_HOME/jre/bin
		else
			export AWT_LIB_PATH=$JAVA_HOME/jre/lib/amd64
		fi
	fi

	# Identity the XTEST library location
	export XTEST_LIB_PATH=/usr/X11R6/lib

	# Fix the pointer size for AMD64
	[[ ${ARCH} == 'amd64' ]] && export SWT_PTR_CFLAGS=-DSWT_PTR_SIZE_64

	einfo "Building AWT library"
	emake -f make_linux.mak make_awt || die "Failed to build AWT support"

	einfo "Building SWT library"
	emake -f make_linux.mak make_swt || die "Failed to build SWT support"

	if use accessibility ; then
		einfo "Building JAVA-AT-SPI bridge"
		emake -f make_linux.mak make_atk || die "Failed to build ATK support"
	fi

	if use gnome ; then
		einfo "Building GNOME VFS support"
		emake -f make_linux.mak make_gnome || die "Failed to build GNOME VFS support"
	fi

	if use mozilla ; then
		if use firefox ; then
			GECKO_SDK=/usr/lib/MozillaFirefox
		else
			GECKO_SDK=/usr/lib/mozilla
		fi

		export GECKO_INCLUDES="-include ${GECKO_SDK}/include/mozilla-config.h \
						-I${GECKO_SDK}/include \
						-I${GECKO_SDK}/include/java \
						-I${GECKO_SDK}/include/nspr -I${GECKO_SDK}/include/nspr/include \
						-I${GECKO_SDK}/include/xpcom -I${GECKO_SDK}/include/xpcom/include \
						-I${GECKO_SDK}/include/string -I${GECKO_SDK}/include/string/include \
						-I${GECKO_SDK}/include/embed_base -I${GECKO_SDK}/include/embed_base/include \
						-I${GECKO_SDK}/include/embedstring -I${GECKO_SDK}/include/embedstring/include"
		export GECKO_LIBS="-L${GECKO_SDK} -lgtkembedmoz"

		einfo "Building the Mozilla component"
		emake -f make_linux.mak make_mozilla || die "Failed to build Mozilla support"
	fi

	if use cairo ; then
		einfo "Building CAIRO support"
		emake -f make_linux.mak make_cairo || die "Unable to build CAIRO support"
	fi

	einfo "Building JNI libraries"
	ant compile || die "Failed to compile JNI interfaces"

	einfo "Creating missing files"
	echo "version 3.135" > ${S}/build/version.txt
	cp ${FILESDIR}/SWTMessages.properties ${S}/build/org/eclipse/swt/internal/

	einfo "Packing JNI libraries"
	ant jar || die "Failed to create JNI jar"
}

src_install() {
	java-pkg_dojar swt.jar || die "Unable to install SWT Java interfaces"

	java-pkg_sointo /usr/lib
	java-pkg_doso *.so || die "Unable to install SWT libraries"

	dohtml about.html
}
