dovecotauth
===========

dovecotauth is a library to connect to dovecot-auth

Usage
-----

    require 'dovecotauth'

    auth = DovecotAuth.new("/path/to/dovecot-auth/socket")
    auth.authenticate("user", "password") # => This will return true or false if you are authenticated
