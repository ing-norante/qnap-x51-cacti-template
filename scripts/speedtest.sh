#!/bin/bash
RESFILE="/var/tmp/speedtestresults"
INTERVAL=1200

if  ((`stat -c %Y /var/tmp/speedtestresults`+$INTERVAL<$(date +%s))); then
        # get fresh data
        RES=`/Apps/opt/bin/speedtest-cli --simple | cut -d" " -f1,2 | sed -e 's/ //g'| tr '\n' ' '`
        echo $RES > $RESFILE
else
        # get fake results from last run
        RES=`cat $RESFILE`
fi

echo $RES
