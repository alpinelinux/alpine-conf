SETUP-DNS(8) "Alpine Linux"

# NAME

*setup-dns* - configure DNS settings

# SYNOPSIS

*setup-dns* [\-h] [\-d _DOMAIN_] [_IPADDR_...]

# DESCRIPTION

*setup-dns* writes DNS resolver configuration to _/etc/resolv.conf_. It sets
the search domain and one or more nameserver addresses.

Current values from _/etc/resolv.conf_ or the FQDN are offered as
defaults when prompting.

When _IPADDR_ arguments are given, nameserver configuration is
non-interactive. The *\-d* option supplies the search domain, but without
_IPADDR_ arguments the script still prompts for nameservers.

# OPTIONS

*\-d* _DOMAIN_
	Set the DNS search domain.

*\-h*
	Display usage information and exit.

# FILES

_/etc/resolv.conf_
	DNS resolver configuration file.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# SEE ALSO

*resolv.conf*(5), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
