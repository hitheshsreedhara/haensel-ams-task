#!/bin/bash

s3_data="https://haensel.s3.amazonaws.com/newdata.txt"

already_running()
{
  # Method to check if the script step2.sh is already runninng
  process_check=$(ps -ef | grep "step2.py"| grep -v grep | wc -l)
  if [ ${process_check} -gt 0 ]; then
    echo 1
  else
    echo 0
  fi
}

function validate_data()
{
  # Method to check if the data exists from step1.sh
  if [[ `wget -S --spider $1  2>&1 | grep 'HTTP/1.1 200 OK'` ]]; then echo "true"; fi
}

check_data()
{
  if [ `validate_data $s3_data` ]; then
    echo 0
  else
    echo 1
  fi
}

exit_script()
{
  # Method to pause the execution of step2.py indefinitely if it failed once and notifies administrator by sending email
  echo "Script step2.py is failing. Please check" | mail -s "step2.py failure" usha26.sm@gmail.com
  exit 1
}

run_script()
{
  status_flag=$(already_running) # Check if step2.py already running
  if [ ${status_flag} -eq 0 ]; then
    echo "step2.py is not running"
    check_file=$(check_data)     # Check if step1.sh has finished and sent data to S3 bucket
    if [ $check_file -eq 0 ]; then
      python step2.py  || exit_script  # Execute step2.py if new data is available
      aws s3 rm s3://haensel/newdata.txt # Delete the data which is already read
      echo "Waiting for next data from step1.sh"
    else
      echo "New Data not available yet from step1.sh" # Wait untill new data is received from step1.sh
    fi
  else
    echo "Already running"
	fi
}

while true
do
	run_script
	sleep 300  #Run script step2.py every 5 minutes
done
