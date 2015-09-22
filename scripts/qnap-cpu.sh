#!/bin/sh

#########################################################################
# cacti script for QNAP NAS
#
# REQUIREMENT: Run qnap-cpu-cron.sh from crontab
# PURPOSE: Obtain CPU utilization from about 1 minute ago
# Usage: <path_cacti>/scripts/qnap-cpu.sh
#
#########################################################################

# Cacti spikes CPU when poller is run, offload it to external process at
# different time, by running it in cronjob every minute, storing it to /tmp file

if [ ! -e /tmp/systemcpu.cacti ]; then
  systemcpu="Error: Create a cronjob"
  exit 1
else
  systemcpu=`cat /tmp/systemcpu.cacti`
fi

printf ' systemcpu:'$systemcpu

exit 0
