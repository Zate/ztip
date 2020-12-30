#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purpose

# Load Redis environment variables
. /opt/bitnami/scripts/redis-env.sh

# Load libraries
. /opt/bitnami/scripts/libbitnami.sh
. /opt/bitnami/scripts/libredis.sh

info "** Starting Redis setup **"
/opt/bitnami/scripts/redis/setup.sh
info "** Redis setup finished! **"



# Start the first process
/opt/bitnami/scripts/redis/run.sh &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_first_process: $status"
  exit $status
fi

# Start the second process
/itip/itip &
status=$?
if [ $status -ne 0 ]; then
  echo "Failed to start my_second_process: $status"
  exit $status
fi

# Naive check runs checks once a minute to see if either of the processes exited.
# This illustrates part of the heavy lifting you need to do if you want to run
# more than one service in a container. The container will exit with an error
# if it detects that either of the processes has exited.
# Otherwise it will loop forever, waking up every 60 seconds

echo "starting up"
while /bin/true; do
  ps aux |grep itip |grep -q -v grep
  PROCESS_1_STATUS=$?
  ps aux |grep redis-server |grep -q -v grep
  PROCESS_2_STATUS=$?
  # If the greps above find anything, they will exit with 0 status
  # If they are not both 0, then something is wrong
  if [ $PROCESS_1_STATUS -ne 0 -o $PROCESS_2_STATUS -ne 0 ]; then
    echo "One of the processes has already exited."
    exit -1
  fi
  sleep 60
done
