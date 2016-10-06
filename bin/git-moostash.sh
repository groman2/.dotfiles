#!/bin/bash
CMD=$0
PRETEND=
set -e
#set -x
GITDIR=$(git rev-parse --git-dir  2>/dev/null)
BACKUP_INDEX=
BRANCH=$(git rev-parse --abbrev-ref HEAD)


if [ "$BRANCH" == "HEAD" ];
then
    ID=$(git rev-parse HEAD | cut -b 1-12)
    TOPTR="STASH-$ID"
else
    TOPTR="STASH-$BRANCH"
fi
set +e
git branch $TOPTR 2>/dev/null 1>/dev/null
set -e

if ! git diff-index --cached --quiet HEAD -- 2>/dev/null 1>/dev/null
then
    NUM=0
    while BACKUP_INDEX=$GITDIR/index.bak.$NUM; NUM=$((NUM+1)); test -f $BACKUP_INDEX; do :; done

    cp -f $GITDIR/index $BACKUP_INDEX
    echo Backed up index
    git reset HEAD 1>/dev/null
fi

BACKPTR=$(git rev-parse HEAD 2>/dev/null)
TOP=$(git rev-parse --show-toplevel 2>/dev/null)

if git symbolic-ref HEAD -- 2>/dev/null 1>/dev/null
then
    BACKPTR=$(git symbolic-ref HEAD)
fi

if ! git rev-parse --verify $TOPTR 2>/dev/null 1>/dev/null
then
    echo Cannot find $TOPTR as a branch or a ref, bailing
    exit 1
fi

if git rev-parse --symbolic-full-name $TOPTR 2>/dev/null 1>/dev/null
then
    TOPTR=$(git rev-parse --symbolic-full-name $TOPTR 2>/dev/null)
    $PRETEND git symbolic-ref HEAD $TOPTR 1>/dev/null
else
    $PRETEND git update-ref HEAD $TOPTR 1>/dev/null
fi
# Re-enable point of no return
set +e
$PRETEND git reset HEAD 1>/dev/null
$PRETEND git add $TOP/ 1>/dev/null
$PRETEND git commit "$*"
if [ "$?" == "0" ]
then
    $PRETEND git diff --stat HEAD HEAD^
else
    echo No changes detected, nothing saved
fi

if [[ $(git rev-parse --symbolic-full-name $BACKPTR) != "" ]];
then
    BACKPTR=$(git rev-parse --symbolic-full-name $BACKPTR 2>/dev/null)
    $PRETEND git symbolic-ref HEAD $BACKPTR 1>/dev/null
else
    $PRETEND git checkout $(git rev-parse HEAD 2>/dev/null) 1>/dev/null
    $PRETEND git reset --soft $BACKPTR 1>/dev/null
    # $PRETEND git checkout $BACKPTR 1>/dev/null
    # $PRETEND git update-ref HEAD $BACKPTR 1>/dev/null
    # $PRETEND git checkout $BACKPTR 1>/dev/null
fi

$PRETEND git reset HEAD 1>/dev/null
if [ "$BACKUP_INDEX" != "" ] && [ -f $BACKUP_INDEX ] && [ -e $BACKUP_INDEX ]; then
    cp -f $BACKUP_INDEX $GITDIR/index
    echo Restored index
fi