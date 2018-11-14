#!/bin/env bash

if /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg $1
  then 
echo "Restarting Nagios XI processes and services..."
./managerestarts.sh
elif [ ! -e "$1" ]
  then
echo "Errors found. Restarts aborted."
fi
