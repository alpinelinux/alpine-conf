SETUP-PROXY(8) "Alpine Linux"

# NAME

*setup-proxy* - configure HTTP/FTP proxy settings

# SYNOPSIS

*setup-proxy* [\-hq] [_PROXYURL_]

# DESCRIPTION

*setup-proxy* configures the system-wide HTTP, HTTPS and FTP proxy. It
writes the proxy environment to _/etc/profile.d/proxy.sh_ and installs
*wget*, since the busybox *wget* does not support HTTP proxies.

In interactive mode, the proxy URL must be an HTTP or HTTPS URL (e.g.
*http://proxy:8080*) or *none*. The value *none* removes the proxy
configuration.

If _PROXYURL_ is given, it is used directly. If omitted, the current
proxy setting is the default and the user is prompted.

# OPTIONS

*\-h*
	Display usage information and exit.

*\-q*
	Quiet mode. Suppress the reminder to source the profile after setup.

# FILES

_/etc/profile.d/proxy.sh_
	Shell script exporting _http_proxy_, _https_proxy_, _ftp_proxy_ and
	_no_proxy_ environment variables.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# SEE ALSO

*wget*(1), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
