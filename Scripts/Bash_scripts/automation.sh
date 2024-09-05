#!/bin/bash

# edit cron tab to schedule script to execute at 12AM everyday
crontab -e

0 0 * * * /c/Users/hp/Downloads/Scripts/Bash_Scripts/etl_process.sh

crontab -l #list the details of the edit

