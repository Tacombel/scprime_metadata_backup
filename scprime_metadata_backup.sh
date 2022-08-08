#!/bin/bash

# Temporary folder. You need to create this folder in the OS
temp="/home/daniel/temp"

# Where to backup.
dest="/mnt/SATA2/metadata_backups"

# route to metadata
metadata="/var/lib/docker/volumes/scprime01_scp-data/_data"

rsync -azvv --exclude consensus/ $metadata $temp

hour=$(date +%H)
day=$(date +%A)

if (( $hour == 23 )); then
    tar czf $dest/scprime-$day.tgz $temp
    # optional. Copy to Storj DCS
    # uplink cp $dest/scprime01-$day.tgz sj://backups
else
    tar czf $dest/scprime-$hour.tgz $temp
    # optional. Copy to Storj DCS
    # uplink cp $dest/scprime01-$day.tgz sj://backups
fi
