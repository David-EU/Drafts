#!/bin/bash
dpkg --set-selections < backup_dpkg_installed.txt
wait 2
apt-get dselect-upgrade
