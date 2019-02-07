system_user_group_adding_changing.yml
------------

Playbook for local users and groups creation and changing

Description
------------
* Playbook creates group if %GroupName% var is provided
* Playbook adds ssh-key for the user if %SshKey% var is provided
* Playbook resets system account if it exists with chage, pam_tally, pam_tally2

# User creation logic:
* If local user doesn't exist and doesn't exist not local account (SAMBA/NIS etc ) - it'll create local user
* If local user exists - it'll change password only
* If local user doesn't exist but not local account (SAMBA/NIS etc) exists  - it'll print message about it only


Requirements
------------
Tested for Ansible 2.4
Tested for SLES 10/11/12, CentOS 5/6/7, RHEL 5/6/7, Ubuntu 14/16/17/18


Vars
------------

Variables for playbook must be included in user_group_list.yml file. You can find vars examples there.
* UserID - required, account user id
* Uid - optional, user uid
* UserName - optional, user info aka comment
* sha512_hash - required, sha512 password hash (it's used on almost all modern OS)
* md5_hash - required, md5 password hash (sometimes sha512 hash doesn't work on old OS such as CentOS 5, SLES 10 etc)
* group - optional, primary groupname/gid for the user
* GroupName - optional, group name which should be created
* GroupID - optional, gid for the created group
* SshKey - optional, ssh-rsa key which should be added for the user

Tags
-------------

* reset_account - for resetting account (chage, pam_tally(2)) only
* ssh_key - for adding ssh-key only

Additional information
-------------

It's useful for use this playbook via [Jenkins](https://jenkins.io/) or other automation server - you can insert all variables via web form and save a lot of time for routine tasks. Working Jenkins job config example is attached.