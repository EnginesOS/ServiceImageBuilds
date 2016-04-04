divert(0)dnl
#
#   Copyright (c) 2000-2002 Richard Nelson.  All Rights Reserved.
#
#  This file is used to configure Sendmail for use with Debian systems.
#
define(`_USE_ETC_MAIL_')dnl
include(`/usr/share/sendmail/cf/m4/cf.m4')dnl
VERSIONID(`$Id: submit.mc, v 8.14.4-4.1ubuntu1 2014-02-11 13:02:08 cowboy Exp $')
OSTYPE(`debian')dnl
DOMAIN(`debian-msp')dnl
dnl #
dnl #---------------------------------------------------------------------
dnl # Masquerading information, if needed, should go here
dnl # You likely will not need this, as the MTA will do it
dnl #---------------------------------------------------------------------
dnl MASQUERADE_AS()dnl
dnl FEATURE(`masquerade_envelope')dnl
dnl #
dnl #---------------------------------------------------------------------
dnl # The real reason we're here: the FEATURE(msp)
dnl # NOTE WELL:  MSA (587) should have M=Ea, so we need to use stock 25
dnl #---------------------------------------------------------------------
FEATURE(`msp', `[127.0.0.1]', `25')dnl
dnl #
dnl #---------------------------------------------------------------------
dnl # Some minor cleanup from FEATURE(msp)
dnl #---------------------------------------------------------------------
dnl #
dnl #---------------------------------------------------------------------
define(`SMART_HOST', `smtp.engines.internal')
CLIENT_OPTIONS(`Family=inet, M=S, Addr=0.0.0.0')dnl
