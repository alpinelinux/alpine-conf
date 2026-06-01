SETUP-ALPINE(8) "Alpine Linux"

# NAME

*setup-alpine* - Alpine Linux installation and configuration script

# SYNOPSIS

*setup-alpine* [\-ahq] [\-c _FILE_ | \-f _FILE_]

# DESCRIPTION

*setup-alpine* is the main system setup script for Alpine Linux. It
interactively walks through keyboard layout, hostname, networking, timezone,
package repository selection, user creation, SSH daemon configuration, and
disk installation.

The script sources a number of helper scripts from the same package, each
responsible for a specific subsystem.

If run over SSH (detected via *SSH_CONNECTION*), networking is not restarted
while configuring the hostname and interfaces so that the remote connection is
not disrupted.

# OPTIONS

*\-a*
	Create an Alpine Linux overlay archive without performing a disk
	installation. Files are written to a temporary directory instead of
	the live root.

*\-c* _FILE_
	Create an answer file template at _FILE_ and exit without making any
	changes. The generated file contains common variables with
	descriptive comments.

*\-e*
	Set an empty root password (skip password prompting).
	Implied by *\-q*.

*\-f* _FILE_
	Use the answer file _FILE_ for a non-interactive installation.
	_FILE_ can also be an HTTP, HTTPS, or FTP URL - the script downloads
	it and sets up temporary networking if needed.

*\-h*
	Display usage information and exit.

*\-q*
	Quick mode. Sets the hostname to "alpine", configures the first CDN
	mirror (see *setup-apkrepos*(8)), and skips timezone, proxy, NTP,
	user, SSH daemon, disk installation, and overlay backup configuration.
	Implies *\-e*.

# ANSWER FILE

When *\-c* is used, *setup-alpine* writes a template answer file.
A populated answer file passed with *\-f* is sourced as a shell script.
The following variables are recognized:

*KEYMAPOPTS*
	Arguments for *setup-keymap*(8). The value "none" skips keymap
	configuration.

*HOSTNAMEOPTS*
	Hostname argument for *setup-hostname*(8).

*DEVDOPTS*
	Device manager to configure via *setup-devd*(8).

*INTERFACESOPTS*
	Contents of _/etc/network/interfaces_. If set to "none", networking
	is left unconfigured.

*WIFIOPTS*
	Path to a *wpa_supplicant.conf*(5) file passed to
	*setup-interfaces*(8).

*DNSOPTS*
	Arguments for *setup-dns*(8).

*TIMEZONEOPTS*
	Timezone argument for *setup-timezone*(8). The value "none" skips
	timezone configuration.

*PROXYOPTS*
	Proxy URL for *setup-proxy*(8). The value "none" skips proxy
	configuration.

*APKREPOSOPTS*
	Arguments for *setup-apkrepos*(8) (e.g. *\-1* for the CDN mirror).

*USEROPTS*
	Arguments for *setup-user*(8). If unset, a default interactive user
	setup is performed.

*USERSSHKEY*
	SSH public key or URL for the user, passed with *\-k* to
	*setup-user*(8).

*SSHDOPTS*
	SSH daemon argument for *setup-sshd*(8).

*ROOTSSHKEY*
	SSH public key or URL for root, passed with *\-k* to
	*setup-sshd*(8).

*NTPOPTS*
	NTP client argument for *setup-ntp*(8). The value "none" skips NTP
	configuration.

*DISKOPTS*
	Disk installation arguments for *setup-disk*(8). The value "none"
	skips disk installation.

*LBUOPTS*
	Local backup medium argument for *setup-lbu*(8). The value "none"
	skips lbu configuration.

*APKCACHEOPTS*
	APK cache directory argument for *setup-apkcache*(8). The value
	"none" skips cache configuration.

*XENDOM0OPTS*
	Arguments for *setup-xen-dom0*(8) (only applicable in Xen Dom0
	environments).

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# FILES

_/etc/network/interfaces_
	Network interface configuration written by *setup-interfaces*(8).

# SEE ALSO

*lbu*(8), *setup-apkcache*(8), *setup-apkrepos*(8), *setup-devd*(8),
*setup-disk*(8), *setup-dns*(8), *setup-hostname*(8), *setup-interfaces*(8),
*setup-keymap*(8), *setup-lbu*(8), *setup-ntp*(8), *setup-proxy*(8),
*setup-sshd*(8), *setup-timezone*(8), *setup-user*(8), *setup-xen-dom0*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
