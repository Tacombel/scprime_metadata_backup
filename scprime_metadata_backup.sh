#!/bin/bash

# Temporary folder. You need to create this folder in the OS
temp="/home/daniel/temp"

# Where to backup.
dest="/mnt/SATA2/metadata_backups"

# route to metadata
metadata="/var/lib/docker/volumes/scprime01_scp-data/_data"

# This is the command to stop spd, a container in my case. You should use spc host stop
docker stop scprime
rsync -azvv --exclude consensus/ $metadata $temp
#This is the command to restart. Set it to your own start command for spd
docker start scprime

hour=$(date +%H)
day=$(date +%A)

if (( $hour == 23 )); then
    tar czf $dest/scprime-$day.tgz $temp
    # Optional. Copy to Storj DCS
    # uplink cp $dest/scprime01-$day.tgz sj://backups
else
    tar czf $dest/scprime-$hour.tgz $temp
    # Optional. Copy to Storj DCS
    # uplink cp $dest/scprime01-$day.tgz sj://backups
fi

echo "Finished metadata backup
