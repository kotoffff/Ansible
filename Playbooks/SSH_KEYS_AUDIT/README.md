ssh_public_keys_presence_report.yml
===========

Playbook for **~/.ssh/authorized_keys** file checking for all user accounts and report file with info about existing ssh keys, user info, latest access date etc creation


Description
------------
* Playbook checks home dirs for users and find which users have **~/.ssh/authorized_keys** file
* Playbook finds all info about users which have **~/.ssh/authorized_keys** file - is it local/samba/NIS account, is it locked/disabled or not if account is local, etc
* Playbook checks log files and finds when specific user with specific ssh key enters on server
* Playbook creates **summary_ssh_keys_info.csv** report file with full information which has been found on previous steps

Requirements
------------
* Tested for Ansible 2.4
* Tested for SLES 11/12, CentOS 6/7, RHEL 6/7, Ubuntu 14/16/17/18

Additional information
-------------

You can use *convert_csv_to_xlsx.py*  python script for converting **summary_ssh_keys_info.csv** file to **ssh_keys_audit_report.xlsx** file. It creates useful xlsx file with autofilter, freezed first row etc.