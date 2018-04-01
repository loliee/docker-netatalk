# Netatalk

[![Build Status](https://travis-ci.org/loliee/docker-netatalk.svg?branch=master)](https://travis-ci.org/loliee/docker-netatalk)

Another netatalk docker image.

## Vars

### `NETATALK_USERS`

Array of users to create.

For each user you should also export the following vars:

- `NETATALK_[USERNAME]_UID` user `uid`
- `NETATALK_[USERNAME]_PASSWD` user password
