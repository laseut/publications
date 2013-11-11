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
    echo "Changes detected. Updating database..."
elif [ "$1" = "-f" ] ; then
    echo "Forcing update of database..."
else
    # No changed were made
    echo "No changes."
    exit 0
fi

# Changes were made
rm update_database.sql
echo "**************"
echo "Running jabref"
echo "**************"
jabref -n -o update_database.sql,mysql publications.bib
echo $?
echo "*************"
echo "Running mysql"
echo "*************"
mysql --user=root --password=galliumnitride -D publications < update_database.sql
echo $?
exit 0
