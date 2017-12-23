#!/bin/bash

# Rsync weekly backup
# Syncing by SSH and compressed


# Configuration variables
MOUNT_DEVICE="/dev/sdb1";
SNAPSHOT_DIR="/backups/snapshots";
REMOTE_DIR="/";
REMOTE_SERVER="root@localhost";
SSH_KEY="/home/username/.ssh/id_dsa";
EXCLUDES="$SNAPSHOT_DIR/excludes";
RSYNC_OPTIONS="-az --delete";
DEBUG="1";
# Fixed variables
ID=`/usr/bin/id -u`;
RUNNING=`ps aux | grep rsync | grep -v grep | wc -l`;
LOGFILE="$SNAPSHOT_DIR/logs/week."`date +%F`".log" ;


# (Re)initialising logfile
echo "Logs for rsync backup : " `date` > $LOGFILE ;
echo "Filename : $LOGFILE" >> $LOGFILE ;
echo " " >> $LOGFILE ;


# Debug mode
if (( $DEBUG == 1 )) ;
then {
        echo "Debug mode ON, here is the variables list :" >> $LOGFILE ;
        echo "ID : $ID " >> $LOGFILE ;
        echo "MOUNT_DEVICE : $MOUNT_DEVICE" >> $LOGFILE ;
        echo "SNAPSHOT_DIR : $SNAPSHOT_DIR" >> $LOGFILE ;
        echo "REMOTE_DIR : $REMOTE_DIR" >> $LOGFILE ;
        echo "EXCLUDES : $EXCLUDES" >> $LOGFILE ;
        echo "SSH_KEY : $SSH_KEY" >> $LOGFILE ;
        echo "REMOTE_SERVER : $REMOTE_SERVER" >> $LOGFILE ;
        echo "RSYNC_OPTIONS : $RSYNC_OPTIONS" >> $LOGFILE ;
        echo "RUNNING : $RUNNING" >> $LOGFILE ;
        echo "LOGFILE : $LOGFILE" >> $LOGFILE ;
        echo " " >> $LOGFILE ;
}
fi ;


# Verify if all is ok for doing backup
echo "Starting conditions checking..." >> $LOGFILE ;
echo "  Checking directories..." >> $LOGFILE ;
cd $SNAPSHOT_DIR
if [ -d logs ] ;
        then { echo "    logs : ok" >> $LOGFILE ; }
        else { mkdir -v $SNAPSHOT_DIR/logs >> $LOGFILE ; }
fi ;
if [ -d week.1 ] ;
        then { echo "    week.1 : ok" >> $LOGFILE ; }
        else { mkdir -v $SNAPSHOT_DIR/week.1 >> $LOGFILE ; }
fi ;
if [ -d week.2 ] ;
        then { echo "    week.2 : ok" >> $LOGFILE ; }
        else { mkdir -v $SNAPSHOT_DIR/week.2 >> $LOGFILE ; }
fi ;
if [ -d week.3 ] ;
        then { echo "    week.3 : ok" >> $LOGFILE ; }
        else { mkdir -v $SNAPSHOT_DIR/week.3 >> $LOGFILE ; }
fi ;
echo "  Directories check : done" >> $LOGFILE ;
if (( $ID != 0 )) ;
        then { echo "  Not running on root user ! Aborting..." >> $LOGFILE ; exit ; }
        else { echo "  Running on root : ok" >> $LOGFILE ; }
fi ;
#if (( $RUNNING != 0 )) ;
#        then { echo "  Rsync already running ! Aborting..." >> $LOGFILE ; exit ; }
#        else { echo "  Rsync not running : ok" >> $LOGFILE ; }
#fi ;
#mount -o remount,rw $MOUNT_DEVICE $SNAPSHOT_DIR ;
#if (( $? )) ;
#       then { echo "  Could not remount $SNAPSHOT_DIR read-write ! Aborting..." >> $LOGFILE ; exit ; }
#       else { echo "  Remount in read-write : done" >> $LOGFILE ; }
#fi ;


# Cycling directories
echo "Starting directory cycling..." >> $LOGFILE ;
cd $SNAPSHOT_DIR ;
mv week.3 week.tmp ;
mv week.2 week.3 ;
mv week.1 week.2 ;
mv week.tmp week.1 ;
if (( $? )) ;
        then { echo "  Could not cycling directories ! Aborting..." >> $LOGFILE ; exit ; }
        else { echo "  Directory rotation : done" >> $LOGFILE ; }
fi ;


# Backup with recycling oldest backup to speed up process
echo "Starting rsync process..." >> $LOGFILE ;
if (( $DEBUG == 1 )) ;
        then { echo "  Execute : rsync $RSYNC_OPTIONS -e \"ssh -i $SSH_KEY\" $REMOTE_SERVER:$REMOTE_DIR $SNAPSHOT_DIR/week.1/" >> $LOGFILE ; }
fi ;
rsync $RSYNC_OPTIONS -e "ssh -i $SSH_KEY" $REMOTE_SERVER:$REMOTE_DIR $SNAPSHOT_DIR/week.1/ >> $LOGFILE ;
if (( $? )) ;
        then { echo "  Could not syncing data ! Aborting..." >> $LOGFILE ; exit ; }
        else { echo "  Rsync backup : done" >> $LOGFILE ; }
fi ;
touch $SNAPSHOT_DIR/week.1/ ;
if (( $? )) ;
        then { echo "  Could not touch week.1 ! Continue..." >> $LOGFILE ; }
        else { echo "  Touching week.1 : done" >> $LOGFILE ; }
fi ;
sync ;
if (( $? )) ;
        then { echo "  Could not sync Hard-Drive ! Aborting..." >> $LOGFILE ; exit ; }
        else { echo "  Syncing Hard-Drive : done" >> $LOGFILE ; }
fi ;
#mount -o remount,ro $MOUNT_DEVICE $SNAPSHOT_DIR ;
#if (( $? )) ;
#       then { echo " Could not remount $SNAPSHOT_DIR read-only ! Aborting..." >> $LOGFILE ; exit ; }
#       else { echo "  Remount in read-only : done" >> $LOGFILE ; }
#fi ;



# Ending logfile
echo " " >> $LOGFILE ;
echo "Backed up " `du -hs $SNAPSHOT_DIR/week.1/` >> $LOGFILE ;
echo "Rsync job done without any fatal errors : " `date` >> $LOGFILE ;

#Remount in read-only to prevent damages
#echo "Remounting in read-only" >> $LOGFILE ;
#echo "Could no more logging here because of read-only... bye bye" >> $LOGFILE ;
#mount -o remount,ro $MOUNT_DEVICE $SNAPSHOT_DIR ;

