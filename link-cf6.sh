#!/bin/bash

set -e

if [ ! -L /usr/local/bin/cf6 ]; then
  ln -s /usr/local/bin/cf /usr/local/bin/cf6
fi
