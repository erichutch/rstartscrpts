#!/bin/env bash

if /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg $1
  then 
echo "Rebooting Nagios XI server..."
./rebootnxi.sh
elif [ ! -e "$1" ]
  then
echo "Errors found. Not rebooting."
fi
