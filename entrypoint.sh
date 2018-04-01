#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

# NETATALK_CONFIG config file path, default to /etc/afp.conf
NETATALK_CONFIG=${NETATALK_CONFIG:-'/etc/afp.conf'}

# NETATALK_USERS list of user login names separated by space
NETATALK_USERS=${NETATALK_USERS:-}

if [ -n "${NETATALK_USERS}" ]; then
  for user in ${NETATALK_USERS}; do
    vpasswd=$(echo "NETATALK_${user}" | awk '{print toupper($0)}')_PASSWD
    vuid=$(echo "NETATALK_${user}" | awk '{print toupper($0)}')_UID

    # shellcheck disable=SC2086
    if [ -z ${!vpasswd+x} ]; then
      echo "${vpasswd} is undefined"
      exit 1
    fi

    # shellcheck disable=SC2086
    if [ -z ${!vuid+x} ]; then
      echo "${vuid} is undefined"
      exit 1
    fi

    grep "${user}" /etc/passwd || {
      adduser --uid "${!vuid}" \
          --no-create-home --disabled-password \
          --gecos '' \
          "${user}"
      echo "${user}:${!vpasswd}" | chpasswd
    }
  done
fi

cat "${NETATALK_CONFIG}"

exec netatalk -d -F "${NETATALK_CONFIG}"
