Alpine Conf are a set of utilities for making backup of config files and for setting up a new Alpine Linux computer.

LBU:

* Basic usage:

To add a file or folder to be backed up, lbu include /path/to/foo
To remove a file from being backed up, lbu exclude /path/to/foo
To setup LBU options, edit /etc/lbu/lbu.conf
To create a package as specified in lbu.conf, lbu commit
To override destination of the backup package, lbu package /path/to/bar.apkovl.tar.gz

Setup scripts:

The main script is called setup-alpine, and it will perform basic system setup
Each script can be called independently, for example:
	setup-acf	Sets up ACF web interface
	setup-ntp	Sets up NTP service
	etc

For further information, please see http://alpinelinux.org/apk/main/x86/alpine-conf or
the Alpine Linux documentation wiki at http://wiki.alpinelinux.org
