#!/bin/sh

# This script is used for development purpose only in order to check the `git
# status` on the main playbook and the sub-projects roles in the `roles/`
# directory.

# Master ansible playbook directory.
DIRECTORY="$(dirname "$(realpath "$0")")/"
echo
while test $# -gt 0; do
  case "$1" in
    -f|--full)
            # Check the playbook status.
              echo -e "\e[32mrepo: $DIRECTORY\e[0m"
              git --git-dir="$DIRECTORY".git --work-tree=$DIRECTORY status
              echo

            # Check the status of all sub-projects in the `roles/` directory.
            for d in "$DIRECTORY"roles/*/; do
                echo -e "\e[32mrepo: $d\e[0m"
                git --git-dir=$d.git --work-tree=$d status
                echo
            done
            exit 0
            ;;
    -p|--pull)
            # Pull online playbook.
              echo -e "\e[32mrepo: $DIRECTORY\e[0m"
              git --git-dir="$DIRECTORY".git --work-tree=$DIRECTORY pull
              echo

            # Pull one by one all sub-projects in the `roles/` directory.
            for d in "$DIRECTORY"roles/*/; do
                echo -e "\e[32mrepo: $d\e[0m"
                git --git-dir=$d.git --work-tree=$d pull
                echo
            done
            exit 0
            ;;

    *)
            echo -e "\e[31mWrong parameter. Printing default output:\e[0m"
            echo
            break
            ;;
  esac
done

# Check the playbook status.
if [[ $(git --git-dir="$DIRECTORY".git --work-tree=$DIRECTORY status -s) ]]; then
  echo -e "\e[31mXX repo:\e[0m $DIRECTORY"
  git --git-dir="$DIRECTORY".git --work-tree=$DIRECTORY status -s
else
  echo -e "\e[32mOK repo:\e[0m $DIRECTORY"
fi

# Check the status of all sub-projects in the `roles/` directory.
for d in "$DIRECTORY"roles/*/; do
  if [[ $(git --git-dir=$d.git --work-tree=$d status -s) ]]; then
    echo -e "\e[31mXX repo:\e[0m $d"
    git --git-dir=$d.git --work-tree=$d status -s
  else
    echo -e "\e[32mOK repo:\e[0m $d"
  fi
done
