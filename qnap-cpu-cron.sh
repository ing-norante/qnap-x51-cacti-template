#!/bin/sh
#
# cacti script for QNAP NAS TS-451
#
# REQUIREMENT: Add the crontab into the autorun.sh script to ensure it survives
#              the reboot.  Check Wiki for QNAP autorun.sh script
#
# PURPOSE: Obtain CPU utilization of QNAP NAS, it will be run every minute
#
# Example autorun.sh inclusion:
#   cat >> /etc/config/crontab <<\EOF
#   * * * * * /share/MD0_DATA/Web/cacti/scripts/qnap-cpu-cron.sh >/dev/null 2>&1
#   EOF
#   crontab /etc/config/crontab
#

PWD ="cactipoller"

# Avoid crontab collision with Cacti's per-minute poller
sleep 50
# Assumes SNMP settings, change if needed
/opt/bin/snmpget -v 3 -a MD5 -A $PWD -l authNoPriv -t 6 -u cactipoller localhost .1.3.6.1.4.1.24681.1.2.1.0 |cut -d\" -f2 | cut -d' ' -f1 |awk '{ printf($1) }' >/tmp/systemcpu.cacti

exit 0
