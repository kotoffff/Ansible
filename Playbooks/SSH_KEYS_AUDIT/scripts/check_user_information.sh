#!/bin/bash

#script for checking if account is local and/or samba(AD) and/or NIS. Also it checks account is disabled and/or locked if account is local.
# $1 - username
# $2 - tmp dir name

TMP_DIR=$2

#checking local account
LOCAL_ACCOUNT=$(grep ^$1: /etc/passwd )
if [ ! -z "${LOCAL_ACCOUNT}" ]; then
  echo "Yes" > $TMP_DIR/local_account.txt
#check if local account is locked or not
  SHADOW_CHECKING=$(grep ^$1: /etc/shadow)
  if [ ! -z "${SHADOW_CHECKING}" ]; then
    LOCKING_CHECKING=$(grep ^$1: /etc/shadow | awk -F":" '{ print $2 }' | grep ^! )
    if [ ! -z "${LOCKING_CHECKING}" ]; then
      echo "Yes" > $TMP_DIR/locked_account.txt
    else
      echo "No" > $TMP_DIR/locked_account.txt
    fi
  fi  
#check if local account is disabled or not
  DISABLED_CHECKING=$(grep ^$1: /etc/shadow | awk -F ':' '{print $8}')
  if [ -z "${DISABLED_CHECKING}" ]; then
    echo "No" > $TMP_DIR/disabled_account.txt
  else
    DATE_TODAY=$(($(date +%s)/(3600*24)))
    if [ $DISABLED_CHECKING -le $DATE_TODAY ];then
      echo "Yes" > $TMP_DIR/disabled_account.txt
    else
      echo "No" > $TMP_DIR/disabled_account.txt
    fi
  fi
else
  echo "No" > $TMP_DIR/local_account.txt
  echo 'No' > $TMP_DIR/locked_account.txt
  echo 'No' > $TMP_DIR/disabled_account.txt
fi

#checking samba account
SAMBA_ACCOUNT=$(wbinfo -n $1 )
if [ ! -z "${SAMBA_ACCOUNT}" ]; then
  echo "Yes" > $TMP_DIR/samba_account.txt
else
  echo "No" > $TMP_DIR/samba_account.txt
fi

#checking NIS account
NIS_ACCOUNT=$(ypcat passwd | grep ^$1: )
if [ ! -z "${NIS_ACCOUNT}" ]; then
  echo "Yes" > $TMP_DIR/nis_account.txt
else
  echo "No" > $TMP_DIR/nis_account.txt
fi