#!/bin/sh

#########################################################################
# cacti script for QNAP NAS
# Partly based on work from: http://pnpk.net
#
# REQUIREMENT: You must install "bc" - run "ipkg install bc"
# PURPOSE: Obtain disk volume information
# Usage: <path_cacti>/scripts/qnap-volume.sh <hostname> <snmp_community>
#
#########################################################################

BC_PATH="/opt/bin/bc"
PWD="cactipoller"

hdtotalsize=`/opt/bin/snmpget -v 3 -a MD5 -A $PWD -l authNoPriv -u cactipoller localhost .1.3.6.1.4.1.24681.1.2.17.1.4.1 |cut -d\" -f2 | cut -d' ' -f1 |awk '{ printf($1) }'`
hdfreesize_snmp=`/opt/bin/snmpget -v 3 -a MD5 -A $PWD -l authNoPriv -u cactipoller localhost .1.3.6.1.4.1.24681.1.2.17.1.5.1`

# First assign free size based on the assumption TB
hdfreesize=`echo $hdfreesize_snmp |cut -d\" -f2 | cut -d' ' -f1 |awk '{ printf($1) }'`

# If the string "GB" is found, divide the variable by 1024 to convert GB to TB size
if [[ "$hdfreesize_snmp" == *" GB"* ]]; then
  hdfreesize=`echo "scale=2; $hdfreesize / 1024" | $BC_PATH`
fi

# If the string "MB" is found, divide the variable by 1048576 to convert MB to TB size
if [[ "$hdfreesize_snmp" == *" MB"* ]]; then
  hdfreesize=`echo "scale=2; $hdfreesize / 1048576" | $BC_PATH`
fi

hdusedsize=`echo "scale=2; $hdtotalsize - $hdfreesize" | $BC_PATH |awk '{ printf($1) }'`

printf ' hdtotalsize:'$hdtotalsize
printf ' hdfreesize:'$hdfreesize
printf ' hdusedsize:'$hdusedsize

exit 0
