#!/bin/bash
SRCFOLDER=$1
INFILE=$(echo -n $2 | cut -b 3-)

if [[ -f "$SRCFOLDER/$INFILE" ]];
then
    DEST=$INFILE
    DIR=$(dirname $INFILE)
    if [[ ! -d $DIR ]];
    then
        echo Creating $DIR
        mkdir -p $DIR
    fi
    ln -v $SRCFOLDER/$INFILE $INFILE
fi
