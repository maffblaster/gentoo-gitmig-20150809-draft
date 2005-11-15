#!/sbin/runscript
# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/cancd/files/netconsole-init.d,v 1.1 2005/11/15 19:27:35 robbat2 Exp $

depend() {
	need net
}

start() {
	checkconfig || return 1
	if [ -z "${TGT_MAC}" ]; then
		LC_ALL=C /bin/ping -nq -c 3 "${TGT_IP}" -I "${DEVICE}" 1>/dev/null 2>/dev/null
		ret=$?
		# ping worked, try arp
		if [ $ret -eq 0 ]; then
			TGT_MAC="$(LC_ALL=C arp -an -i ${DEVICE} ${TGT_IP} |egrep -v 'incomplete|no match' | awk '{print $4}')"
		fi
	elif [ "${TGT_MAC}" == "broadcast" ]; then
		TGT_MAC=''
	fi
	ebegin "Starting netconsole ${SRC_IP}:${SRC_PORT}(${DEVICE}) -> ${TGT_IP}:${TGT_PORT} ${TGT_MAC}"
	# else we use the MAC that we are given
	modprobe netconsole netconsole=${SRC_PORT}@${SRC_IP}/${DEVICE},${TGT_PORT}@${TGT_IP}/${TGT_MAC}
	ret=$?
	[ $ret -eq 0 ] && dmesg -n ${LOGLEVEL}
	eend $ret
}

stop() {
	ebegin "Stopping netconsole"
	modprobe -r netconsole
	eend $?
}

checkconfig() {
	# kernel uses 15 internally
	if [ "$LOGLEVEL" -lt 0 -o "${LOGLEVEL}" -gt 15 ]; then
		eerror "Invalid kernel console loglevel."
		return 1
	fi

	if [ "$SRC_PORT" -le 0 ]; then
		eerror "Invalid source port."
		return 1
	fi

	LC_ALL=C /sbin/ifconfig "${DEVICE}" 1>/dev/null 2>/dev/null
	ret=$?

	if [ -z "${DEVICE}" -o "${ret}" -gt 0 ]; then
		eerror "Source device invalid."
		return 1
	fi

	if [ "$TGT_PORT" -le 0 ]; then
		eerror "Invalid target port."
		return 1
	fi

	if [ -z "$TGT_IP" ]; then
		eerror "Unspecified target address."
		return 1
	fi

	return 0
}

# netconsole=[src-port]@[src-ip]/[dev],[tgt-port]@<tgt-ip>/[tgt-macaddr]
#        src-port      source for UDP packets (defaults to 6665)
#        src-ip        source IP to use (interface address)
#        dev           network interface (eth0)
#        tgt-port      port for logging agent (6666)
#        tgt-ip        IP address for logging agent
#        tgt-macaddr   ethernet MAC address for logging agent (broadcast)

# vim: ts=4 sw=4 sts=4:
