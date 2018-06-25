# Haensel-ams-task
This repository is for provising solution to the ETL Pipeline Orchestration

## Objective:
https://github.com/haensel-ams/recruitment_challenge/tree/master/DevOps_201709 

## Solution:

### Directory Structure:
```
.
├── README.md      
├── instance1       #Scripts to run in AWS EC2 instance1
│   ├── step1.sh
│   └── wrapper1.sh
└── instance2       #Scripts to run in AWS EC2 instance2
    ├── step2.py
    └── wrapper2.sh
```
### Task 1 :
1. The script ```wrapper1.sh``` runs the script ```step1.sh``` in every 2 hours insterval.
2. It NEVER starts ```step1.sh``` script again if the previous run is still running.
3. It re-runs the ```step1.sh``` script immediately if it failed (exit code >0).
4. The script ```step1.sh``` writes data into S3 storage before it exits into a bucket by name ```haensel``` and provides read access to the stored data.

### Task 2 :
1. The script ```wrapper2.sh``` runs the script ```step2.py``` soon after script step1.sh has finished and the new data are available.
2. It NEVER starts ```step2.py``` script again if the previous run is still running.
3. It pauses the execution of ```step2.py``` indefinitely if it failed once and notifies administrator by sending email to "etl-admin@example.com".

#### PS - I created a S3 storage bucket called ```haensel``` and ```step1.sh``` script writes data to the S3 storage before exiting upon successful execution.
