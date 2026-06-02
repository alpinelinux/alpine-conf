SETUP-HOSTNAME(8) "Alpine Linux"

# NAME

*setup-hostname* - set the system hostname

# SYNOPSIS

*setup-hostname* [\-h] [_HOSTNAME_]

# DESCRIPTION

*setup-hostname* writes _HOSTNAME_ to _/etc/hostname_. Hostnames are limited
to 255 characters and may only contain letters, digits (0-9), periods
('.') and hyphens ('-'). A hostname must not start with a hyphen or
period.

If _HOSTNAME_ is given, it is validated and written. If validation fails
the script exits with an error.

Without _HOSTNAME_, the current hostname is the default and the user is
prompted for a value.

# OPTIONS

*\-h*
	Display usage information and exit.

# FILES

_/etc/hostname_
	System hostname file. This file is read at boot.

# EXIT STATUS

0
	Success.

1
	The specified hostname failed validation.

# SEE ALSO

*hostname*(1), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
