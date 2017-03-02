# Ansible playbook for Aegir on CentOS 7

This is an Ansible playbook to setup a Vagrant, multi VM system.

For more information about the Vagrant machines see [vagrant-multi-vm](https://github.com/tovletoglou/vagrant-multi-vm).

## Requirements

Tested on CentOS 7

## Get started

1. Clone this project

  ```
  git clone https://github.com/tovletoglou/ansible-playbook-aegir-centos.git
  ```

2. Run the playbook `playbook_ansible.yml`. It will get all the roles and put them in `roles/ansible-role-name` (TODO: add roles ansible galaxy).

  ```
  ansible-playbook -i hosts_vagrant playbook_ansible.yml
  ```

3. Run the playbook `playbook_vagrant` to initialize the servers.

  ```
  ansible-playbook -i hosts_vagrant playbook_vagrant.yml
  ```

4. Run the playbook `playbook_webserver` to setup the web servers.

  ```
  ansible-playbook -i hosts_vagrant playbook_webserver.yml
  ```

5. Run the playbook `playbook_hostmaster` to setup Aegir.

  ```
  ansible-playbook -i hosts_vagrant playbook_hostmaster.yml
  ```

If you like to run the playbooks against physical testing servers use the `hosts_test` using ansible vault.

```
ansible-vault decrypt hosts_test
ansible-playbook -i hosts_test playbook_full_stack_aegir.yml --ask-vault-pass
```

## Extra info

### git-subrepo

The sub-directories in the `callback_plugins` folder are git projects integrated with the [git-subrepo](https://github.com/ingydotnet/git-subrepo). You can recognize them by the `.gitrepo` file.

Do not commit changes of the sub-projects on the main project.

### galera

The `playbook_galera.yml` is working but doesn't used by Aegir.

### git_check_status.sh

The `git_check_status.sh` is a bash script used to check the `git status` for the roles (as sub-projects)
