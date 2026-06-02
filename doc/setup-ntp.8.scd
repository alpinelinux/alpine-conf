SETUP-NTP(8) "Alpine Linux"

# NAME

*setup-ntp* - configure NTP time synchronization

# SYNOPSIS

*setup-ntp* [\-h] [busybox | openntpd | chrony | none]

# DESCRIPTION

*setup-ntp* installs and configures an NTP client. It supports busybox's
ntpd, *openntpd* and *chrony*. The value *none* skips NTP setup.

When an NTP client is specified as an argument, the script runs
non-interactively. Without an argument, it interactively prompts for a
choice. The user can also enter a date string to set the system time before
selecting an NTP client.

After installation, the NTP service is enabled in the *default* runlevel and
started.

# OPTIONS

*\-h*
	Display usage information and exit.

# INTERACTIVE MODE

Without an argument, the script shows the current time and prompts:

	Which NTP client to run? ('busybox', 'openntpd', 'chrony'
	or 'none')

The default is *busybox*. The user may also enter a date string to set the
system clock via *date -s*, useful when the system has no battery-backed
clock.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# SEE ALSO

*ntpd*(8), *openntpd*(8), *chronyd*(8), *date*(1), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
