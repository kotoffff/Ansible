ansible_cfg_backup.yml
===========

Playbook for downloading  config files from servers and save it in local directory

Requirements
------------
* User must have sudo /bin/cat permissions for several tasks
* Tested for Ansible 2.4
* Tested for SLES 11/12, CentOS 6/7, Ubuntu 14/16/17/18

Vars
------------

* download_on_demand - must be set to "True" if you want download backup archive in current directory
* download_on_schedule - must be set to "True" if you want download backup archive in directory wich you want
* dst_dir - must be set it to path where your backup archive should be saved. You must provide this var if download_on_schedule is set to "True"

##### Please use above variables with --extra-vars method:
http://docs.ansible.com/ansible/latest/playbooks_variables.html#passing-variables-on-the-command-line

###
Example:
```
--extra-vars "download_on_demand=True" 
--extra-vars "dst_dir=/tmp download_on_schedule=True"
```
