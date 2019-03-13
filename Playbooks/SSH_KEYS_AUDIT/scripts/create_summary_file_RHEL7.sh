#!/bin/bash

#script for checking last user access data and create summary file about user on RHEL7 OS
# $1 - username
# $2 - tmp dir name
# $3 - {{ansible_hostname}}
# $4 - {{ansible_default_ipv4.address}}

USERNAME=$1
TMP_DIR=$2
ANSIBLE_HOSTNAME=$3
ANSIBLE_DEFAULT_IPV4_ADDRESS=$4

IFS=$'\n'
access_date=""
latest_access_date=""

LOCAL_USER=$(cat $TMP_DIR/local_account.txt)
LOCKED_LOCAL_USER=$(cat $TMP_DIR/locked_account.txt)
DISABLED_LOCAL_USER=$(cat $TMP_DIR/disabled_account.txt)
SAMBA_USER=$(cat $TMP_DIR/samba_account.txt)
NIS_USER=$(cat $TMP_DIR/nis_account.txt)

for a in $(cat $TMP_DIR/key_info.tmp)
do
  for i in $(grep -i $(echo $a | awk '{print $2}') /var/log/secure* | cut '-d:' -f2- | awk '{print $1,$2,$3}')
  do 
    access_date+=$(date --date="$i" +%m-%d_%H:%M:%S)$'\n'
  done
  latest_access_date=$(echo $access_date | tr ' ' "\n" | sort | tail -n 1)
  if [ -z "$latest_access_date" ]
  then 
      latest_access_date="No information"
  fi
  echo $ANSIBLE_HOSTNAME,$ANSIBLE_DEFAULT_IPV4_ADDRESS,$USERNAME,$LOCAL_USER,$LOCKED_LOCAL_USER,$DISABLED_LOCAL_USER,$SAMBA_USER,$NIS_USER,$(echo $a | awk '{print $2}'),$(echo $a | awk '{$1=$2="";print}'),$latest_access_date | sed -e 's/,\s\+/,/g'  >> $TMP_DIR/key_info_with_access_date.txt
done