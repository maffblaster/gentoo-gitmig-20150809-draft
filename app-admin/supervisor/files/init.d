#!/sbin/runscript
# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/supervisor/files/init.d,v 1.1 2010/03/09 13:45:32 djc Exp $

checkconfig() {
	if [ ! -f /etc/supervisord.conf ] ; then
		eerror "Please create /etc/supervisord.conf:"
		eerror "echo_supervisord_conf >> /etc/supervisord.conf"
		return 1
	fi
	return 0
}

start() {
	checkconfig || return $?
	ebegin "Starting supervisord"
	start-stop-daemon --start \
		--exec /usr/bin/supervisord -b --pidfile /var/run/supervisord.pid \
		-- -n ${SUPD_OPTS}
	eend $?
}

stop() {
	ebegin "Stopping supervisord"
	start-stop-daemon --stop --pidfile /var/run/supervisord.pid
	eend $?
}
