#/bin/bash

echo '' > /etc/motd
# echo -n $(head -n1 /etc/issue) >> /etc/motd
# echo -n ' - ' >> /etc/motd
# echo $(uname -rvm) >> /etc/motd
echo $(cat /proc/version) >> /etc/motd

echo '' >> /etc/motd
echo 'OVH server    : r27262.ovh.net' >> /etc/motd
echo -n 'IP            : ' >> /etc/motd
echo $(hostname -i) >> /etc/motd
echo -n 'Hostname      : ' >> /etc/motd
echo $(hostname) >> /etc/motd

echo '' >> /etc/motd
#echo 'User informations :' >> /etc/motd
echo -n 'User : '  >> /etc/motd
echo -n $(whoami) >> /etc/motd

echo -n ' in directory ' >> /etc/motd
echo -n $(pwd) >> /etc/motd

echo -n ' on terminal '  >> /etc/motd
echo -n $(tty) >> /etc/motd

echo -n ' and running '  >> /etc/motd
echo -n $(ps aux | wc -l) >> /etc/motd
echo ' process.' >> /etc/motd

echo '' >> /etc/motd
echo 'Connected users :' >> /etc/motd
who >> /etc/motd

echo '' >> /etc/motd
echo 'Lasts logins :' >> /etc/motd
last | head -n 5 >> /etc/motd

#echo '' >> /etc/motd
#echo 'System informations :' >> /etc/motd

echo '' >> /etc/motd
echo -n 'Uptime : ' >> /etc/motd
echo $(uptime) >> /etc/motd

echo '' >> /etc/motd
echo 'Disk usage :' >> /etc/motd
df -h | grep -e sda -e Sys >> /etc/motd

echo '' >> /etc/motd
echo 'Memory usage :' >> /etc/motd
free -m -o -t >> /etc/motd

echo '' >> /etc/motd
echo 'Network usage :            Input :              Output :             Total :' >> /etc/motd
bwm-ng -a -d -o plain -c 1 | grep /s >> /etc/motd
#bwm-ng -a -d -o plain -c 1 -I eth0 | grep eth0 #>> /etc/motd

echo '' >> /etc/motd
