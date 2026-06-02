SETUP-APKCACHE(8) "Alpine Linux"

# NAME

*setup-apkcache* - configure apk package cache

# SYNOPSIS

*setup-apkcache* [\-h] [_DIR_]

# DESCRIPTION

*setup-apkcache* sets up a local directory for caching apk packages
downloaded from the network. A cache allows packages to be installed
before the network is available, such as at boot time.

The selected directory is mounted if needed, and _/etc/apk/cache_ is
created as a symbolic link to it.

If _DIR_ is not given, the script prompts interactively.

The value *none* disables caching.

# OPTIONS

*\-h*
	Display usage information and exit.

# INTERACTIVE MODE

Without a _DIR_ argument, the script suggests a cache directory. The
suggestion is chosen from:

- the current _/etc/apk/cache_ symlink target, if any
- _/media/__LBU_MEDIA__/cache_ (from lbu.conf)
- _/media/usb/cache_ (when /dev/usbdisk exists)
- _/var/cache/apk_ (when root is not on tmpfs)
- *none* otherwise

The prompt accepts *none* to skip, or *?* for help text describing
the purpose of a local cache.

# FILES

_/etc/apk/cache_
	Symbolic link to the cache directory.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# SEE ALSO

*apk*(8), *setup-lbu*(8), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
