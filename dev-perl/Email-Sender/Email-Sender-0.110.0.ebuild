# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Email-Sender/Email-Sender-0.110.0.ebuild,v 1.3 2011/12/18 19:59:00 phajdan.jr Exp $

EAPI=3

MODULE_AUTHOR=RJBS
MODULE_VERSION=0.110000
inherit perl-module

DESCRIPTION="A library for sending email"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="virtual/perl-Scalar-List-Utils
	virtual/perl-File-Spec
	>=dev-perl/Email-Abstract-3
	dev-perl/Email-Simple
	dev-perl/List-MoreUtils
	dev-perl/Net-SMTP-SSL
	dev-perl/Sub-Exporter
	dev-perl/Throwable
	dev-perl/Try-Tiny
	virtual/perl-libnet
	dev-perl/Moose
	dev-perl/Email-Address"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31
	test? (
		>=dev-perl/Capture-Tiny-0.08
	)"
#		dev-perl/JSON
#		dev-perl/Test-MinimumVersion
#		dev-perl/Sub-Override
#		dev-perl/Test-MockObject )"

SRC_TEST=do

src_test() {
	# https://rt.cpan.org/Public/Bug/Display.html?id=54642
	mv "${S}"/t/smtp-via-mock.t{,.disable} || die
	perl-module_src_test
}
