#!/bin/bash
# Usage:
# 
# Update if any changes:
#     ./update.sh
# 
# Force update:
#     ./update.sh -f
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$THIS_DIR"

S1="$(git pull origin)"
if [[ "$S1" == *"files changed"* ]] ; then
    echo "**************************************"
    echo "Changes detected. Updating database..."
    echo "**************************************"
elif [ "$1" = "-f" ] ; then
    echo "*****************************"
    echo "Forcing update of database..."
    echo "*****************************"
else
    # No changed were made
    exit 0
fi

# Changes were made
rm update_database.sql
echo "**************"
echo "Running jabref"
echo "**************"
jabref -n -o update_database.sql,mysql publications.bib
echo "Exit code: $?"
echo "*************"
echo "Running mysql"
echo "*************"
mysql --user=root --password=galliumnitride -D publications < update_database.sql
echo "Exit code: $?"
exit 0
