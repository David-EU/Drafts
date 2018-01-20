#!/bin/bash

#variables
DATE=$(date +"%Y-%m-%d_%Hh%M")
WDIR="/opt"
CTL="sudo /etc/init.d"
GIT="sudo git"

#arret des softs
$CTL/couchpotato stop
$CTL/nzbdrone stop
$CTL/sickrage stop
$CTL/headphones stop
$CTL/jackett stop
$CTL/plexpy stop
python $WDIR/pyload/pyLoadCore.py --quit
sleep 10

#lance les mises a jours
cd $WDIR/jackett
#$GIT bundle create $WDIR/jackett.$DATE.git-bundle --all  #La création d'un colis requiert un dépot
#$GIT pull #.......
#abandon update via git, utilisation script update Jackett:.
# https://www.htpcguides.com/install-jackett-ubuntu-15-x-for-custom-torrents-in-sonarr/
# https://github.com/Jackett/Jackett/pull/9/commits/38f06a4192e3a301b9132b75881da0142de71616
WVERSION=$(curl https://github.com/Jackett/Jackett/releases/latest -s -L -I -o /dev/null -w '%{url_effective}'| grep -o 'v[0-9.].[0-9.].[0-9.][0-9][0-9]')
sudo wget -q https://github.com/Jackett/Jackett/releases/download/$WVERSION/Jackett.Binaries.Mono.tar.gz
sudo chown nightboy:nightboy Jackett.Binaries.Mono.tar.gz

cd $WDIR/NzbDrone
$GIT bundle create $WDIR/NzbDrone.$DATE.git-bundle --all #La création d'un colis requiert un dépot
$GIT pull #......

cd $WDIR/CouchPotatoServer
$GIT bundle create $WDIR/CouchPotatoServer.$DATE.git-bundle --all
$GIT pull

cd $WDIR/SickRage
$GIT bundle create $WDIR/SickRage.$DATE.git-bundle --all
$GIT pull

cd $WDIR/headphones
$GIT bundle create $WDIR/headphones.$DATE.git-bundle --all
$GIT pull

cd $WDIR/plexpy
$GIT bundle create $WDIR/plexpy.$DATE.git-bundle --all
$GIT pull

cd $WDIR/pyload
$GIT bundle create $WDIR/pyload.$DATE.git-bundle --all
$GIT checkout .  #Permet d'annuler les modifications de fichiers (car bloque les mises a jours)
$GIT pull

cd $WDIR
sudo chown -R username:username *

#relance les softs
$CTL/couchpotato start
$CTL/nzbdrone start
$CTL/sickrage start
$CTL/headphones start
$CTL/jackett start
$CTL/plexpy start
python $WDIR/pyload/pyLoadCore.py --daemon
