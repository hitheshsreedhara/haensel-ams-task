#!/bin/bash

echo -n "Running step1... "

sleep `expr $RANDOM / 4 + 3600`

if [ $RANDOM -gt 29000 ]; then
    echo "FAILED!"
    exit 1
fi

echo "DONE!"

# Write some data into AWS S3 bucket before exiting
echo "I am coming from step1.sh $(date)" > test.txt
aws s3 cp test.txt s3://haensel/newdata.txt --acl public-read
