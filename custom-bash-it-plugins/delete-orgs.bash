#!/usr/bin/env bash

function delete_orgs() {
  echo "Warning! All of your orgs and everything in them will be deleted!"

  i=1

  cf orgs | while read line; do
    echo $line
    if [ $i -gt 3 ]; then
      cf delete-org -f "$line";
    fi
    ((i++))
  done

}

export -f delete_orgs
