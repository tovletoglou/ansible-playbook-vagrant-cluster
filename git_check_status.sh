#!/bin/bash

# This script is used for development purpose only in order to check the `git
# status` on the main playbook and the sub-projects roles in the `roles/`
# directory.
#
# Ansible Galaxy doesn't give the SCM files (.git) of a role:
# http://stackoverflow.com/questions/40469084/ansible-galaxy-keep-scm-files
#
# So we `git clone` the roles with `ansible-playbook -i hosts playbook_ansible.yml`
# and ignore them by the main project in the `.gitignore` file.
#
# Finally check the project status we run this script `./git_check_status.sh`.

# Find the path of the script.
[[ -n ${ZSH_VERSION-} ]] &&
  PROJECT_ROOT="$0" ||
  PROJECT_ROOT="$BASH_SOURCE"
[[ $PROJECT_ROOT =~ ^/ ]] ||
  PROJECT_ROOT="$PWD/$PROJECT_ROOT"

PROJECT_FILE=$PROJECT_ROOT
PROJECT_ROOT="$(cd "$(dirname $PROJECT_ROOT)"; pwd)"

# Check playbook status.
if [[ $(git -C "$PROJECT_ROOT" status -s) ]]; then
  echo -e "\e[31mXX Directory:\e[0m $PROJECT_ROOT"
  git -C "$PROJECT_ROOT" status -s
else
  echo -e "\e[32mOK Directory:\e[0m $PROJECT_ROOT"
fi

# Check the status of all sub-projects in the `roles/` directory.
for d in "$PROJECT_ROOT"/roles/*/; do
  if [[ $(git -C "$d" status -s) ]]; then
    echo -e "\e[31mXX Directory:\e[0m $d"
    git -C "$d" status -s
  else
    echo -e "\e[32mOK Directory:\e[0m $d"
  fi
done
