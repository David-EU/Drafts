#!/bin/bash

#Updating system parts
echo '#1 Getting new releases...'
sudo apt-get update
echo '-----------------------------------------------------------------------'
echo '#2 Cleaning database...'
sudo apt-get autoclean
echo '-----------------------------------------------------------------------'
echo '#3 Cleaning packages...'
sudo apt-get autoremove
echo '-----------------------------------------------------------------------'
echo '#1 Checking dependencies...'
sudo apt-get check
echo '-----------------------------------------------------------------------'
echo '#1 Upgrading...'
sudo apt-get upgrade
echo '-----------------------------------------------------------------------'
echo '#1 Upgrading distribution...'
sudo apt-get dist-upgrade
echo '-----------------------------------------------------------------------'
echo '#1 Trying to upgrade to a new Ubuntu release...'
do-release-upgrade
echo '-----------------------------------------------------------------------'

#Updating applications --> launching dedicated script to update apps?
#CouchPotato
cd /opt/CouchPotatoServer
git pull
#SickRage
/opt/SickRage
git pull
#plexpy
/opt/plexpy
git pull
#pyload
/opt/pyload
git pull

#NONGIT /opt/NzbDrone
#NONGIT /opt/jackett.


#Updating Plex Media Server
#Trouver addresse ici : https://www.plex.tv/downloads/
cd /home/username
wget https://downloads.plex.tv/plex-media-server/1.5.5.3634-995f1dead/plexmediaserver_1.5.5.3634-995f1dead_amd64.deb
sudo dpkg -i plexmediaserver_1.5.5.3634-995f1dead_amd64.deb
#rm plexmediaserver_1.5.5.3634-995f1dead_amd64.deb

