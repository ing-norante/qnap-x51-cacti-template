#!/bin/sh

#########################################################################
# cacti script for QNAP NAS
# Partly based on work from: http://pnpk.net
#
# REQUIREMENT: You must install "bc" - run "ipkg install bc"
# PURPOSE: Obtain memory utilization
# Usage: <path_cacti>/scripts/qnap-memory.sh <hostname> <snmp_community>
#
#########################################################################

BC_PATH="/Apps/opt/bin/bc"

freemem=`/Apps/opt/bin/snmpget -v 3 -a MD5 -A cactipoller -l authNoPriv -u cactipoller localhost .1.3.6.1.4.1.24681.1.2.3.0 |cut -d\" -f2 | cut -d' ' -f1 |awk '{ printf($1) }'`
totalmem=`/Apps/opt/bin/snmpget -v 3 -a MD5 -A cactipoller -l authNoPriv -u cactipoller localhost .1.3.6.1.4.1.24681.1.2.2.0 |cut -d\" -f2 | cut -d' ' -f1 |awk '{ printf($1) }'`
usedmem=`echo $totalmem - $freemem | $BC_PATH |awk '{ printf($1) }'`

printf ' freemem:'$freemem
printf ' totalmem:'$totalmem
printf ' usedmem:'$usedmem

exit 0
