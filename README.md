# Netatalk

[![Build Status](https://travis-ci.org/loliee/docker-netatalk.svg?branch=master)](https://travis-ci.org/loliee/docker-netatalk)

Another netatalk docker image.

## Version

[3.1.11](http://netatalk.sourceforge.net/3.1/htmldocs/)

## Vars

 varname                     | required   | description                                                             |
-----------------------------|------------|-------------------------------------------------------------------------|
`NETATALK_CONFIG`            |  no        | configuration file to use, default to `/etc/afp.conf`                   |
`NETATALK_USERS`             |  no        | list of user to create separated by a space                             |
`NETATALK_[USERNAME]_UID`    |  yes*      | user uid, *required only if `username` defined in `NETATALK_USERS`      |
`NETATALK_[USERNAME]_PASSWD` |  yes*      | user password, *required only if `username` defined in `NETATALK_USERS` |

## License

`MIT / BSD`
