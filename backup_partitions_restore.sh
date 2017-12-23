#!/bin/bash
if (( $1 == $null ))
then { echo "Veuiller indiquer le nom du disque (ex: hda, sdb, ...)" ; }
else { sfdisk /dev/$1 < backup_partitions_df.txt ; }
fi ;
