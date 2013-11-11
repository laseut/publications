#!/bin/bash
# Usage:
# 
# Update if any changes:
#     ./update.sh
# 
# Force update:
#     ./update.sh -f

S1="$(git pull origin)"
S2="Already up-to-date."
echo $S1
update=false
if [ "$S1" != "$S2" ] ; then
    update=true
    echo "Changes detected. Updating database..."
elif [ "$1" = "-f" ] ; then
    update=true
    echo "Forcing update of database..."
fi
if $update ; then
    # Changes were made
    jabref -n -o update_database.sql,mysql publications.bib
    echo $?
    mysql --user=root --password=galliumnitride -D publications < update_database.sql
    echo $?
    rm update_database.sql
    exit 0
else
    # No changed were made
    echo "No changes."
    exit 0
fi
