# Ansible playbook for Vagrant Playground

This is an Ansible playbook used to setup a Vagrant playground with multiple servers for different testing purposes.<br>
For more information about the Vagrant blueprint see [vagrant-playground](https://github.com/tovletoglou/vagrant-playground).

## Requirements

Tested on CentOS 7.

## Get started

1. Clone the project and cd in.

  ```
  git clone https://github.com/tovletoglou/ansible-playbook-vagrant-playground.git
  cd ansible-playbook-vagrant-playground
  ```

2. [Optional] Edit the `hosts` accordingly, edit the IP addresses to reflect the VMs.

3. Run the playbook `playbook_ansible.yml`. It will get all the necessary roles and put them in `roles/ansible-role-name`.

  ```
  ansible-playbook -i hosts playbook_ansible.yml
  ```

4. Run the playbook `playbook_vagrant` to initialize the servers.

  ```
  ansible-playbook -i hosts playbook_vagrant.yml
  ```

5. Now you can run any specific playbook to provision the corresponding VM/VMs.<br>
  For example run the playbook `playbook_hostmaster` to setup Aegir Drupal hosting system.

  ```
  ansible-playbook -i hosts playbook_hostmaster.yml
  ```

## Running on live VM

If you like to run the playbooks against online testing servers, create a new `hosts` file and encrypt it with ansible vault.<br>
For example, I use the `hosts_test` to target online testing VMs. `hosts` file does not contain sensitive information (hostname, IP, SSH port, user) although it's good to think twice about the data we encrypt and publish online.

```
ansible-vault decrypt hosts_test
ansible-playbook -i hosts_test playbook_full_stack_aegir.yml --ask-vault-pass
```

## Extra info

## 'roles/' directory

The `roles/` directory will be created after the `ansible-playbook -i hosts playbook_ansible.yml` and contain all the roles for the playbooks.<br>
All the roles are independent projects and ignored by the main project. Check the `.gitignore` file for details.

### 'callback_plugins/' directory

The sub-directories in the `callback_plugins/` are independent git projects integrated with the [git-subrepo](https://github.com/ingydotnet/git-subrepo). You can recognize them by the `.gitrepo` file.

### git_check_status.sh

The `git_check_status.sh` is a bash script used to check the `git status` for the roles (as sub-projects)

### More thinks to do

- TODO: Add roles to ansible galaxy or replace them with similar roles
- TODO: Fix the `playbook_galera.yml`
- TODO: Fix the `playbook_elastic`
- TODO: Fix the `playbook_webserver`
- TODO: Fix the `playbook_swagger`
- TODO: Fix the `playbook_teamcity`
