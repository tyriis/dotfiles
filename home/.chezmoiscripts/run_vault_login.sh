#!/usr/bin/env bash

# Attempt to read from Vault using the current token
vault token lookup -format=json > /dev/null 2>&1

if [ $? -ne 0 ]; then

  echo "Vault token is invalid or expired."
  vault login -method=oidc role=gsuite > /dev/null 2>&1

  if [ $? -ne 0 ]; then

    echo "Vault login failed!"
    exit 1

  fi
fi

exit 0
