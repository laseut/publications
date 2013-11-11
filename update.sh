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
elif [ "$1" = "-f" ] ; then
fi
if $update ; then
    # Changes were made
    echo "Changes detected. Updating database..."
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
