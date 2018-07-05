#!/bin/bash

ID_RSA=~/.ssh/id_rsa

if [ -e $ID_RSA ]; then
  eval "$(ssh-agent -s)"
  ssh-add $ID_RSA
  ssh-add -l
fi

yarn install

exec "$@"
