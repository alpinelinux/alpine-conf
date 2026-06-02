SETUP-SSHD(8) "Alpine Linux"

# NAME

*setup-sshd* - configure the SSH daemon

# SYNOPSIS

*setup-sshd* [\-h] [\-k _KEY_] [openssh | dropbear | none]

# DESCRIPTION

*setup-sshd* installs and configures an SSH server. It supports *openssh*
and *dropbear*. The value *none* skips SSH setup.

When the server is given as an argument, the script runs non-interactively.
Without an argument, it prompts for a choice and, for *openssh*, configures
root login settings and authorized keys.

The *\-k* option specifies an authorized key for root. It can be a public
key, an HTTP/HTTPS/FTP URL, or *none*. The *SSH_KEY*
environment variable is used as the default.

After installation, the SSH service is enabled in the *default* runlevel and
started.

# OPTIONS

*\-k* _KEY_
	Authorized key for root login. Accepts a public key, a URL
	(http, https, ftp), or *none*.

*\-h*
	Display usage information and exit.

# INTERACTIVE MODE

Without a server argument, the script prompts:

	Which ssh server? ('openssh', 'dropbear' or 'none')

For *openssh*, when no authorized key and no unprivileged users exist, the
script prompts:

	Allow root ssh login? ('?' for help)

The accepted values are *yes*, *no*, and *prohibit-password*.
The help text (*?*) explains each option. Shortcuts expand key URLs:

*al* _USER_
	Fetch keys from _https://gitlab.alpinelinux.org/_USER_.keys

*gl* _USER_
	Fetch keys from _https://gitlab.com/_USER_.keys

*gh* _USER_
	Fetch keys from _https://github.com/_USER_.keys

After root login is configured, the script prompts for an authorized key:

	Enter ssh key or URL for root (or 'none')

The *al*, *gl*, *gh* shortcuts apply. A key is validated with
*ssh-keygen*.

# FILES

_/root/.ssh/authorized_keys_
	Authorized keys file for root.

_/etc/ssh/sshd_config_
	OpenSSH configuration file. *setup-sshd* sets *PermitRootLogin*
	here.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# SEE ALSO

*sshd*(8), *dropbear*(8), *ssh-keygen*(1), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
