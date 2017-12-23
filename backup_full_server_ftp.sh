#!/bin/bash
rm /backups/fullbackup.tar.gz
tar -zcpf /backups/fullbackup.tar.gz --directory=/ --exclude=proc --exclude=sys --exclude=dev/pts --exclude=backups

SERVER=url.of.server.com
USER=username
PASSW=password

ftp -n $SERVER <<END_OF_SESSION
user $USER $PASSW
$FILETYPE
lcd /backups
mput fullbackup.tar.gz
bye
END_OF_SESSION
