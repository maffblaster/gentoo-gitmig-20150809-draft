# Copyright 1999-2003 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/zetagrid/files/zeta_progress.sh,v 1.4 2004/07/09 21:42:18 mr_bones_ Exp $

# ======================================================================
#  zeta_progress.sh      Start script for the ZetaGrid progress utility
# ----------------------------------------------------------------------
#
#  This script sets the environment for the ZetaGrid progress utility.
#
#  Please note:
#
#  - You must adopte the Java call below for your environment.
#
#  - This utility reads the progress file 'zeta_zeros.tmp'
#    which only exists when the ZetaGrid client is running.
#
#  Prerequisite: Java Runtime Environment 1.2.2 or higher,
#                e.g. http://java.sun.com/j2se/1.3/download.html
#
# ======================================================================

java -Djava.library.path=. -cp zeta_client.jar zeta.ShowProgress
