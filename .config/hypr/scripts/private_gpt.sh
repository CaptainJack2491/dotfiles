#!/bin/bash

cd ~/temp/privategpt/
PGPT_PROFILES=openai nohup make run &

# Store the process IDs in a file
echo $! > ~/temp/privategpt/pgpt_pid.txt
vivaldi --app=http://0.0.0.0:8001
# Wait for the browser to close
while pgrep -f "vivaldi --app=http://0.0.0.0:8001" > /dev/null; do
    sleep 1
done

# Kill the Private GPT process
kill $(cat ~/temp/privategpt/pgpt_pid.txt)
