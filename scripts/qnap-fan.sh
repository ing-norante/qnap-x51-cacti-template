#!/bin/sh

#########################################################################
# cacti script for QNAP NAS
# Code restructured and updated by Bruce Cheng <email at brucecheng.com>, January 2013
# Partly based on work from: http://pnpk.net
#
# PURPOSE: Obtain fan speed information
# Usage: <path_cacti>/scripts/qnap-fan.sh <hostname> <snmp_community>
#
#########################################################################

fanspeed=`/Apps/opt/bin/snmpget -v 3 -a MD5 -A cactipoller -l authNoPriv -u cactipoller localhost .1.3.6.1.4.1.24681.1.2.15.1.3.1 |cut -d\" -f2 | cut -d' ' -f1 |awk '{ printf($1) }'`

printf ' fanspeed:'$fanspeed

exit 0
