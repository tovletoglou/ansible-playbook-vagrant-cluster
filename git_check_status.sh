#!/bin/sh

# This script is used for development purpose only in order to check the `git
# status` on the main playbook and the sub-projects roles in the `roles/`
# directory.

# Master ansible playbook directory.
DIRECTORY=~/ansible-playbook-aegir-centos/

# Check the playbook status.
if [[ $(git --git-dir="$DIRECTORY".git --work-tree=$DIRECTORY status -s) ]]; then
  echo -e "\e[31mXX\e[0m Directory: $DIRECTORY"
  git --git-dir="$DIRECTORY".git --work-tree=$DIRECTORY status -s
else
  echo -e "\e[32mOK \e[1;30mDirectory: $d\e[0m"
fi

# Check the status of all sub-projects in the `roles/` directory.
for d in "$DIRECTORY"roles/*/; do
  if [[ $(git --git-dir=$d.git --work-tree=$d status -s) ]]; then
    echo -e "\e[31mXX\e[0m Directory: $d"
    git --git-dir=$d.git --work-tree=$d status -s
  else
    echo -e "\e[32mOK \e[1;30mDirectory: $d\e[0m"
  fi
done
