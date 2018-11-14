#!/bin/env bash
# upladevnag02v
# Eric H
# managerestarts.sh
# cron.daily --- added 02/04/2018
#
# Restart Nagios XI, MySQL, and services without reboot daily.
#
serv=/usr/local/nagiosxi/scripts/manage_services.sh > /dev/null 2>&1
echo "Nagios XI `hostname` service restarts for GSDP-13"
echo "Testing GSD email"
echo
while $1
do
echo "Restarting Nagios XI processes and services..."
echo
echo "Stopping services..."
$serv stop npcd > /dev/null 2>&1
$serv status npcd
$serv stop httpd > /dev/null 2>&1
$serv status httpd
$serv stop ndo2db > /dev/null 2>&1
$serv status ndo2db
service snmptt stop > /dev/null 2>&1
service snmptt status
service snmptrapd stop > /dev/null 2>&1
service snmptrapd status
service snmpd stop > /dev/null 2>&1
service snmpd status
# use pkill -9 to stop nagios process
echo "Stopping Nagios XI processes..."
for i in `ipcs -q | grep nagios |awk '{print $2}'`; do ipcrm -q $i; done
pkill -9 -u nagios
$serv status nagios
echo "Stopping mysqld service..."
$serv stop mysqld > /dev/null 2>&1
$serv status mysqld
echo
rm -rf /usr/local/nagios/var/rw/nagios.cmd
rm -rf /usr/local/nagios/var/nagios.lock
rm -rf /usr/local/nagios/var/ndo.sock
rm -rf /usr/local/nagios/var/ndo2db.lock
rm -rf /usr/local/nagiosxi/var/reconfigure_nagios.lock
rm -rf /var/lib/mrtg/mrtg_l
echo
echo "Starting Nagios XI processes and services..."
echo "Starting mysqld service..."
$serv start mysqld > /dev/null 2>&1
$serv status mysqld
echo "Starting Nagios XI..."
$serv start nagios > /dev/null 2>&1
#
ps aux | grep -c nagios | grep -v grep
ps aux | grep nagios | grep -v grep
$serv status nagios
#/usr/local/nagios/bin/nagios -d /usr/local/nagios/etc/nagios.cfg
echo "Starting services..."
service snmpd start > /dev/null 2>&1
service snmptrapd start > /dev/null 2>&1
service snmptt start > /dev/null 2>&1
/usr/local/nagios/bin/ndo2db -c /usr/local/nagios/etc/ndo2db.cfg > /dev/null 2>&1
$serv start httpd > /dev/null 2>&1
$serv start npcd > /dev/null 2>&1
$serv status snmpd
#service snmpd status
service snmptrapd status
service snmptt status
$serv status ndo2db
$serv status httpd
$serv status npcd
service xinetd restart > /dev/null 2>&1
service xinetd status
#echo "Postgresql (postmaster) should show stopped if using mysql db only:"
#$serv status postgresql
echo
/usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg
hostname
exit 
done
exit 0
