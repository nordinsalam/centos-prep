#!/bin/bash
 
 
##########################################################################
### This script will run various operations to prepare a CentOS 6 x64  ###
### server for templating. This would prepare templates for VMWare,    ###
### Proxmox, Virtualbox,etc. The server will automatically be shutdown.###
### Once shutdown, the machine can be converted to a template.         ###
##########################################################################
 
# Update server completely.
 
yum -y update
 
# Clean yum cache.
 
yum clean all
 
# Foce rotating of logs.
 
logrotate -f /etc/logrotate.conf
rm -rf /var/log/*-???????? /var/log/*.gz
 
# Clean audit logs and wtmp.
 
cat /dev/null > /var/log/audit/audit.log
cat /dev/null > /var/log/wtmp
 
# Remove persistent rules.
 
rm -rf /etc/udev/rules.d/70*
 
# Clean temp directories.
 
rm -rf /tmp/*
rm -rf /var/tmp/*
 
# Remove ssh keys.
 
rm -rf /etc/ssh/ssh_host_*
 
# Remove NIC identifiers.
 
sed -i '/^\(HWADDR\|UUID\)=/d' /etc/sysconfig/network-scripts/ifcfg-eth0
 
# Set selinux as permissive.
 
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/sysconfig/selinux
 
# Set the machine as "unconfigured".
 
touch /.unconfigured
 
# Remove history.
 
rm -rf /root/.bash_history
unset HISTFILE
 
# Displaying all clear message.
 
echo "This installation is now ready for templating. Shutting down..."
sleep 3
 
# Shutting down.
 
shutdown -h now
 
# Cleaning up.
 
rm -rf ./templatize-centos-6.sh
 
# Exit
 
exit 0
