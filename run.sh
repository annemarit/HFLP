#!/bin/bash

E1="Aborting"
E2="Automatic merge failed"
E3="Pull is not possible because you have unmerged files."
S1="Merge made by the 'recursive' strategy"
S2="Already up-to-date."

echo "################"
echo "###Test suite###"
echo "################"
while true; do
    echo "Pulling latest changes from Github..."
    GITSTATUS="$(git pull 2>&1)"
    case $GITSTATUS in
        *$E1* )
            echo "There exist un-commited changes. Please resolve before running this script again."
            exit ;;
        *$E2* )
            echo "Automatic merge failed. Please fix manually before running this script again."
            exit ;;
	*$E3* )
            echo "Some files need manual merging. Please fix before running this script again."
	    exit ;;
	*$S1* )
	    break ;;
        *$S2* )
	    break ;;
    esac
    break;
#done
echo "Done pulling."
echo "################"
echo " "
echo "################"

echo "Starting Mosel ..."
mosel exec $1

output_file=${1:14}
output_file=${output_file:0:${#output_file}-3}dat
output_file="output$output_file"

git add $output_file
git commit -m "Test results"
git push
