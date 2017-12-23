#!/bin/bash
echo '' > backup_sysinfo.txt
echo 'OS version :' >> backup_sysinfo.txt
echo -n $(head -n1 /etc/issue) >> backup_sysinfo.txt
echo -n ' - ' >> backup_sysinfo.txt
echo $(uname -rvm) >> backup_sysinfo.txt

echo '' >> backup_sysinfo.txt
echo 'Hostname info :' >> backup_sysinfo.txt
echo $(hostname -i) >> backup_sysinfo.txt
echo $(hostname) >> backup_sysinfo.txt

echo '' >> backup_sysinfo.txt
echo 'Systeme de fichiers :' >> backup_sysinfo.txt
df -h >> backup_sysinfo.txt

echo '' >> backup_sysinfo.txt
echo 'Interfaces reseau :' >> backup_sysinfo.txt
ifconfig >> backup_sysinfo.txt

echo '' >> backup_sysinfo.txt
echo 'Wireless :' >> backup_sysinfo.txt
iwconfig >> backup_sysinfo.txt

echo '' >> backup_sysinfo.txt
echo 'Bus PCI :' >> backup_sysinfo.txt
lspci >> backup_sysinfo.txt

echo '' >> backup_sysinfo.txt
echo 'CPU info :' >> backup_sysinfo.txt
cat /proc/cpuinfo >> backup_sysinfo.txt

echo '' >> backup_sysinfo.txt
echo 'Dmesg :' >> backup_sysinfo.txt
dmesg | egrep '(SCSI|scsi|ide|hda|hdb|sda|sdb|serio|mice|eth)' >> backup_sysinfo.txt

echo '' >> backup_sysinfo.txt
echo 'Modules :' >> backup_sysinfo.txt
lsmod >> backup_sysinfo.txt

echo '' >> backup_sysinfo.txt
echo 'Kernel configuration :' >> backup_sysinfo.txt
cat "/boot/config-`uname -r`" >> backup_sysinfo.txt
