#!/bin/bash

already_running()
{
  # Method to check if the script step1.sh is already runninng
  process_check=$(ps -ef | grep "step1.sh"| grep -v grep | wc -l)
  if [ ${process_check} -gt 0 ]; then
    echo 1
  else
    echo 0
  fi
}

run_script()
{
  status_flag=$(already_running)
  if [ ${status_flag} -eq 0 ]; then
    echo "step1.sh is not running"
    ((exec ./step1.sh ) || (run_script) &) # Executes step1.sh and if it fails it re-runs step1.sh
  else
    echo "Already running"
  fi
}

while true
do
	run_script
	sleep 7200 # Running the script every 2hours
done
