#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

echo "Starting to remove old files"

echo "The following files will be removed: "
find $HOME/Downloads -ctime +30 -print0

read -r -p "Are you sure? [Y/n] " response

case $response in
    [yY][eE][sS]|[yY])
        find $HOME/Downloads -ctime +30 -print0 | xargs -0 rm -rf
        ;;
    *)
        echo "Not deleting anything."
        ;;
esac

