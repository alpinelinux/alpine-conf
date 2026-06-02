SETUP-TIMEZONE(8) "Alpine Linux"

# NAME

*setup-timezone* - set the system timezone

# SYNOPSIS

*setup-timezone* [\-h] [\-k | \-i] [_TIMEZONE_]

# DESCRIPTION

*setup-timezone* configures the system timezone. It installs *tzdata*, copies
or symlinks the selected zoneinfo file, and creates the _/etc/localtime_
symlink.

Without options, *tzdata* is installed as a temporary package and the
zoneinfo is copied to _/etc/zoneinfo/_. With *\-i*, *tzdata* stays
installed and _/etc/localtime_ is symlinked to */usr/share/zoneinfo*.

_TIMEZONE_ is a path relative to */usr/share/zoneinfo*, such as
*America/New_York* or *UTC*. If given on the command line, it is validated
and configured. If *none*, the script exits without changes.

If _TIMEZONE_ is omitted, the script interactively lists timezone areas and
prompts the user to navigate the timezone tree.

# OPTIONS

*\-h*
	Display usage information and exit.

*\-i*
	Install the *tzdata* package permanently and symlink
	_/etc/localtime_ to */usr/share/zoneinfo*/_TIMEZONE_ instead of
	copying.

*\-k*
	Keep existing zoneinfo files in _/etc/zoneinfo/_ when copying.
	Without this option, _/etc/zoneinfo/_ is removed before the new
	file is copied.

# INTERACTIVE MODE

Without a _TIMEZONE_ argument, the script lists available top-level timezone
areas (e.g. *America*, *Europe*) and prompts:

	Which timezone are you in? (or '?' or 'none')

The user can enter an area name to drill into its sub-timezones, *?* to
redisplay the list, or *none* / *abort* to exit. Selecting a directory
shows its sub-timezones with the prompt:

	What sub-timezone of '*AREA*' are you in? (or '?')

This continues until a timezone file is selected.

# FILES

*/usr/share/zoneinfo/*
	IANA timezone database directory.

_/etc/localtime_
	Symlink to the configured timezone.

_/etc/zoneinfo/_
	Local copy of the zoneinfo file when *tzdata* is not permanently
	installed.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred (invalid timezone, install failure).

# SEE ALSO

*tzdata*(8), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
