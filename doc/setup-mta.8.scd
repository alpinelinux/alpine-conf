SETUP-MTA(8) "Alpine Linux"

# NAME

*setup-mta* - configure outgoing SMTP mail server

# SYNOPSIS

*setup-mta* [\-h] [_\SMTPSERVER_]

# DESCRIPTION

*setup-mta* installs *ssmtp* and configures outgoing email via an SMTP
server. If _SMTPSERVER_ is not given, the script prompts interactively.

If an existing _/etc/ssmtp/ssmtp.conf_ is found, the current *mailhub*
value is used as the default. Otherwise, the hostname's domain is used to
suggest *smtp.DOMAIN*.

The script can optionally test the connection to the SMTP server by
connecting to port 25.

The *FromLineOverride* option is enabled in the configuration.

# OPTIONS

*\-h*
	Display usage information and exit.

# FILES

_/etc/ssmtp/ssmtp.conf_
	ssmtp configuration file.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# SEE ALSO

*ssmtp*(8), *ssmtp.conf*(5), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
