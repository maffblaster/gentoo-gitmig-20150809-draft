# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/java-pkg.eclass,v 1.9 2004/06/25 00:39:48 vapier Exp $

inherit base
ECLASS=java-pkg
INHERITED="${INHERITED} ${ECLASS}"
IUSE="${IUSE}"
SLOT="${SLOT}"

java-pkg_doclass()
{
	debug-print-function ${FUNCNAME} $*
	java-pkg_dojar $*
}

java-pkg_dojar()
{
	debug-print-function ${FUNCNAME} $*
	[ -z "$1" ]
	
	if [ -z "${JARDESTTREE}" ] ; then
		JARDESTTREE="lib"
	fi
	
	# Set install paths
	sharepath="${DESTTREE}/share"
	if [ "$SLOT" == "0" ] ; then
		
		shareroot="${sharepath}/${PN}"
		jardest="${shareroot}/${JARDESTTREE}"
		package_env="${D}${shareroot}/package.env"
	else
		shareroot="${sharepath}/${PN}-${SLOT}"
		jardest="${shareroot}/${JARDESTTREE}"
		package_env="${D}${shareroot}/package.env"
	fi

	debug-print "JARDESTTREE=${JARDESTTREE}"
	debug-print "sharepath=${sharepath}"
	debug-print "shareroot=${shareroot}"
	debug-print "jardest=${jardest}"
	debug-print "package_env=${package_env}"


	if [ -n "${DEP_PREPEND}" ] ; then
		for i in ${DEP_PREPEND}
		do
			if [ -f "${sharepath}/${i}/package.env" ] ; then
				debug-print "${i} path: ${sharepath}/${i}"
				if [ -z "${cp_prepend}" ] ; then
					cp_prepend=`grep "CLASSPATH=" "${sharepath}/${i}/package.env" | sed "s/CLASSPATH=//"`
				else
					cp_prepend="${cp_prepend}:"`grep "CLASSPATH=" "${sharepath}/${i}/package.env" | sed "s/CLASSPATH=//"`
				fi
			else
				debug-print "Error:  Package ${i} not found."
				debug-print "${i} path: ${sharepath}/${i}"
				die "Error in DEP_PREPEND."
			fi
			debug-print "cp_prepend=${cp_prepend}"
			
		done
	fi

	if [ -n "${DEP_APPEND}" ] ; then
		for i in ${DEP_APPEND}
		do
			if [ -f "${sharepath}/${i}/package.env" ] ; then
				debug-print "${i} path: ${sharepath}/${i}"
				if [ -z "${cp_append}" ] ; then
					cp_append=`grep "CLASSPATH=" "${sharepath}/${i}/package.env" | sed "s/CLASSPATH=//"`
				else
					cp_append="${cp_append}:"`grep "CLASSPATH=" "${sharepath}/${i}/package.env" | sed "s/CLASSPATH=//"`
				fi
			else
				debug-print "Error:  Package ${i} not found."
				debug-print "${i} path: ${sharepath}/${i}"
				die "Error in DEP_APPEND."
			fi
			debug-print "cp_append=${cp_append}"
		done
	fi

	# Check for arguments
	if [ -z "$*" ] ; then
		echo "${0}: at least one argument needed"
		exit 1
	fi

	# Make sure directory is created
	if [ ! -d "${D}${jardest}" ] ; then
		install -d "${D}${jardest}"
	fi

	for i in $* ; do
		# Check for symlink
		if [ -L "${i}" ] ; then
			cp "${i}" "${T}"
			mysrc="${T}"/`/usr/bin/basename "${i}"`

		# Check for directory
		elif [ -d "${i}" ] ; then
			echo "dojar: warning, skipping directory ${i}"
			continue
		else
			mysrc="${i}"
		fi

		# Install files
		install -m 0644 "${mysrc}" "${D}${jardest}"

		# Build CLASSPATH
		if [ -z "${cp_pkg}" ] ; then
			cp_pkg="${jardest}"/`/usr/bin/basename "${i}"`
		else
			cp_pkg="${cp_pkg}:${jardest}/"`/usr/bin/basename "${i}"`
		fi
	done
	
	# Create package.env
	echo "DESCRIPTION=${DESCRIPTION}" > "${package_env}"
	echo "CLASSPATH=${cp_prepend}:${cp_pkg}:${cp_append}" >> "${package_env}"
}

java-pkg_dowar()
{
	debug-print-function ${FUNCNAME} $*
	[ -z "$1" ]
	
	# Check for arguments
	if [ -z "$*" ] ; then
		echo "${0}: at least one argument needed"
		exit 1
	fi
	
	if [ -z "${WARDESTTREE}" ] ; then
		WARDESTTREE="webapps"
	fi
	
	sharepath="${DESTTREE}/share"
	shareroot="${sharepath}/${PN}"
	wardest="${shareroot}/${WARDESTTREE}"

	debug-print "WARDESTTREE=${WARDESTTREE}"
	debug-print "sharepath=${sharepath}"
	debug-print "shareroot=${shareroot}"
	debug-print "wardest=${wardest}"

	# Patch from Joerg Schaible <joerg.schaible@gmx.de>
	# Make sure directory is created
	if [ ! -d "${D}${wardest}" ] ; then
		install -d "${D}${wardest}"
	fi
	
	for i in $* ; do
		# Check for symlink
		if [ -L "${i}" ] ; then
			cp "${i}" "${T}"
			mysrc="${T}"/`/usr/bin/basename "${i}"`

		# Check for directory
		elif [ -d "${i}" ] ; then
			echo "dowar: warning, skipping directory ${i}"
			continue
		else
			mysrc="${i}"
		fi

		# Install files
		install -m 0644 "${mysrc}" "${D}${wardest}"
	done
}

java-pkg_dozip()
{
	debug-print-function ${FUNCNAME} $*
	java-pkg_dojar $*
}

java-pkg_jar-from()
{
	local pkg=$1
	local jar=$2
	local destjar=$3

	if [ -z "${destjar}" ] ; then
		destjar=${jar}
	fi

	for x in `java-config --classpath=${pkg} | tr ':' ' '`; do
		if [ ! -f ${x} ] ; then
			eerror "Installation problems with jars in ${pkg} - is it installed?"
			return 1
		fi
		if [ -z "${jar}" ] ; then
			ln -sf ${x} $(basename ${x})
		elif [ "`basename ${x}`" == "${jar}" ] ; then
			ln -sf ${x} ${destjar}
			return 0
		fi
	done
	if [ -z "${jar}" ] ; then
	        return 0
	else
		return 1
	fi	     
}

