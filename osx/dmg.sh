#!/bin/sh
# $Id: dmg.sh,v 1.4 2005/08/28 13:08:50 petterik Exp $
#****h* jpgind/dmg.sh
# NAME
#   dmg.sh
# SYNOPSIS
#   dmg.sh <project_name> <project_version>
# PURPOSE
#   Shell script for wrapping up mountable Mac OS X disk image 
#   containing a native installation package.
# SOURCE
#

set -e

NAM=$1
VER=$2
REL=$3

if ([ "$NAM" = "" ] || [ "$VER" = "" ]) ; then 
    echo "usage: dmg.sh <project name> <project version>" 
    exit 1
fi

if [ "$REL" = "" ] ; then 
    REL=1
fi

PRJ=${NAM}-${VER}.pkg
TMPIMG=$$-${PRJ}.dmg
DSKNAM=${NAM}-${VER}-${REL}

if [ ! -d $PRJ ] ; then
    echo " Directory $PRJ does not exist"
    exit 1
fi

for f in $TMPIMG ${DSKNAM}.dmg ${DSKNAM}.dmg.gz ; do 
    if [ -f $f ] ; then
		rm -f $f
    fi
done

# 
BLKS=`du -s $PRJ | awk '{print $1}'`

echo " $PRJ blocks $BLKS"

# man hdutil example adds 100 sectors, min size is 4MB
if [ $BLKS -lt 8192 ] ; then 
    BLKS=8192
else
    BLKS=`expr $BLKS \+ 100`
fi

echo " Using $BLKS sectors for raw image"

hdiutil create $TMPIMG -sectors $BLKS -layout NONE

# Create a /dev/disk device from the image
drive=`hdid -nomount $TMPIMG | awk '{print $1}'`

# Create a new filesystem on the disk device
newfs_hfs -v "${DSKNAM}" -b 4096 /dev/r${drive:t}

# Remount the disk
echo " Image formatted, ejecting ${drive}..."
hdiutil eject ${drive}

echo " Mounting $TMPIMG ..."
drive=`hdid $TMPIMG | awk '{print $1}'`

echo " Searching for ${drive}..."
while [ "$MOUNTPOINT" = "" ] ; do
    MOUNTPOINT=`df -l | grep $drive | awk '{print $6}'`
done
echo " Found $drive at $MOUNTPOINT"

# Unpack the tarball into the mounted filesystem
echo " Copying application..."

tar cf - $PRJ | (cd  $MOUNTPOINT; tar xf -)

# Eject the disk
echo " Ejecting..."
hdiutil eject ${drive}

# Convert the image to a UDIF compressed image 
echo " Compressing..."
hdiutil convert -format UDCO $TMPIMG -o ${DSKNAM}.dmg
gzip ${DSKNAM}.dmg

# Remove the temporary image
echo " Removing scratch image"
rm -f $TMPIMG

ls -l ${DSKNAM}.dmg.gz

md5 ${DSKNAM}.dmg.gz

exit 0

#***** end dmg.sh
