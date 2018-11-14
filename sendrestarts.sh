#!/bin/env bash

#~/scripts/managerestarts
/usr/local/nagiosxi/scripts/managerestarts.sh > /tmp/timelog.log

#mailx -s "Restart of Nagios processes `hostname` " ehutchison@researchnow.com < ~/scripts/timelog.log
mail -s "Daily cron restart of Nagios XI processes `hostname` " globalservicedesk@researchnow.com < /tmp/timelog.log
