# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/webapp-apache.eclass,v 1.6 2003/08/05 17:00:38 stuart Exp $
#
# Author: Stuart Herbert <stuart@gentoo.org>
# 
# Based on discussions held on gentoo-dev mailing list, and a bug report
# contributed by Ian Leitch <port001@w0r.mine.nu> in bug #14870, 
# and robbat2's mod_php ebuild

ECLASS=webapp-apache
INHERITED="$INHERITED $ECLASS"
DEPEND="${DEPEND} net-www/apache"

EXPORT_FUNCTIONS pkg_preinst

# NOTE:
#
# It is deliberate that the functions in this eclass are called
# 'webapp-xxx' rather than 'webapp-apache-xxx'.  This ensures
# that we can drop in eclasses for other web servers without
# having to change the ebuilds!

function webapp-apache-detect ()
{
	APACHEVER=
	has_version '=net-www/apache-1*' && APACHEVER=1 && CONFVER=
	has_version '=net-www/apache-2*' && use apache2 && APACHEVER=2 && CONFVER=2
	[ -z "${APACHEVER}" ] && has_version '=net-www/apache-2*' && APACHEVER=2 && CONFVER=2

	if [ "${APACHEVER}+" = "+" ]; then
		# no apache version detected
		return 1
	fi

	APACHECONF="/etc/apache${CONFVER}/conf/apache${CONFVER}.conf"
	WEBAPP_SERVER="Apache v${APACHEVER}"
}

# run the function, so we know which version of apache we are using

function webapp-detect () {
	webapp-apache-detect || return 1
	webapp-determine-installowner
	webapp-determine-htdocsdir
}

function webapp-determine-htdocsdir ()
{
	webapp-determine-installowner

	HTTPD_ROOT="`grep '^DocumentRoot' ${APACHECONF} | cut -d ' ' -f 2`"
	[ -z "${HTTPD_ROOT}" ] && HTTPD_ROOT="/home/httpd/htdocs"
	keepdir "$HTTPD_ROOT"
	fowners "$HTTPD_USER"."$HTTPD_GROUP" "$HTTPD_ROOT"
	fperms 755 "$HTTPD_ROOT"
}

function webapp-determine-installowner ()
{
	HTTPD_USER="apache"
	HTTPD_GROUP="apache"
}


function webapp-pkg_setup ()
{
	if [ "$1" == "1" ]; then
		msg="I couldn't find an installation of Apache"
		eerror "${msg}"
		die "${msg}"
	fi
}

# shamelessly stolen from Max Kalika <max@gentoo.org>'s horde stuff ;-)
#
# call this from your ebuild's pkg_setup() function!!

function webapp-check-php ()
{
	local missing=""
	local php_use="$(</var/db/pkg/`best_version dev-php/mod_php`/USE)"
	local i

	for i in $* ; do
		if [ ! "`has ${i} ${php_use}`" ] ; then
			missing="${missing} ${i}"
		fi
	done

	# let's tell the user how to fix these problems

	if [ -n "${missing}" ]; then
		eerror "PHP is missing support for one or more options:"
		eerror " ${missing}"
		eerror
		eerror "Please add '${missing}' to your USE flags, and re-install mod_php"
		die "mod_php needs re-compiling with missing options"
	fi

	return 0
}
