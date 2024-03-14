#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

shopt -s expand_aliases

# Enable debugging by setting TRACE=1
if [[ "${TRACE-0}" == "1" ]]; then set -o xtrace; fi

# UPDATE THE FOLLOWING VARIABLES
OUTPUT_DIR="/path/to/output/directory"

# LEAVE THE FOLLOWING VARIABLES UNCHANGED
HOST_IP=$(hostname -i)
DATE=$(date +%Y%m%d)
TIMESTAMP=$(date +%Y-%m-%d_%H:%M:%S)
TABLEHISTOGRAMS_FILENAME="${OUTPUT_DIR}/${HOST_IP}_${DATE}_tablehistograms.out"
PROXYHISTOGRAMS_FILENAME="${OUTPUT_DIR}/${HOST_IP}_${DATE}_proxyhistograms.out"

# If tablehistograms or proxyhistograms file does not exist, create it
# and write the host IP address to the file
# This will happen only once per day with the expectation that there will be only one
# output file per day per command run.
if [[ ! -f "${TABLEHISTOGRAMS_FILENAME}" ]]; then
  touch "${TABLEHISTOGRAMS_FILENAME}"
  echo "$HOST_IP" > "${TABLEHISTOGRAMS_FILENAME}"
fi

if [[ ! -f "${PROXYHISTOGRAMS_FILENAME}" ]]; then
  touch "${PROXYHISTOGRAMS_FILENAME}"
  echo "$HOST_IP" > "${PROXYHISTOGRAMS_FILENAME}"
fi

# Collect tablehistograms and proxyhistograms
# and append to the respective files
echo "${TIMESTAMP}" >> "${TABLEHISTOGRAMS_FILENAME}"
nodetool tablehistograms >> "${TABLEHISTOGRAMS_FILENAME}"

echo "${TIMESTAMP}" >> "${PROXYHISTOGRAMS_FILENAME}"
nodetool proxyhistograms >> "${PROXYHISTOGRAMS_FILENAME}"
