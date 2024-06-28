#!/bin/bash
if [ -z "$1" ]; then
    echo "Usage: $0 <file_with_urls>"
    exit 1
fi
while IFS= read -r arg; do
    pbskids-dl -q $arg
    if [ $? -ne 0 ]; then
	echo "Error: Command failed with non-zero exit code $?. Exiting script."
	exit 1
    fi
done < "$1"

line=$(head -n 1 $1)
mkdir aa1
cd ./aa1
pbskids-dl $line
mkdir aa2
cd ./aa2
pbskids-dl.sh $line
