SETUP-USER(8) "Alpine Linux"

# NAME

*setup-user* - create a user account

# SYNOPSIS

*setup-user* [\-a] [\-f _FULLNAME_] [\-g _GROUPS_] [\-h] [\-k _SSHKEY_] [\-u] [_\USERNAME_]

# DESCRIPTION

*setup-user* creates a user account, optionally adds it to groups, installs
SSH authorized keys, and sets up privilege escalation via *doas*.

If _USERNAME_ is not specified, the script runs interactively. Without
flags, *none* for _USERNAME_ makes the script exit immediately.

# OPTIONS

*\-a*
	Create an admin user. The user is added to the *wheel* group and
	*doas* is configured with *permit persist :wheel* in
	_/etc/doas.d/20-wheel.conf_.

*\-f* _FULLNAME_
	Set the full name for the new user.

*\-g* _GROUPS_
	Comma- or space-separated list of supplementary groups.

*\-h*
	Display usage information and exit.

*\-k* _SSHKEY_
	SSH authorized key for the user. Accepts a raw key string, an
	HTTP/HTTPS URL, or *none*. The value *none* skips key setup.

*\-u*
	Unlock the user with *passwd -u*, intended for non-interactive use
	when a key-based login is configured.

# INTERACTIVE MODE

Without a _USERNAME_ argument, the script prompts:

	Setup a user? (enter a lower-case loginname, or 'no')

The default is derived from the full name (if *\-f* was given) or *no*.
The user is then prompted for a full name, set via *adduser -g*, and for a
password via *passwd*.

If *\-k* was not given, the script prompts for an SSH key or URL. The
prompt accepts these shortcuts:

*al*
	Expand to _https://gitlab.alpinelinux.org/__USER__.keys_.

*gl*
	Expand to _https://gitlab.com/__USER__.keys_.

*gh*
	Expand to _https://github.com/__USER__.keys_.

# FILES

_/home/__USER__/.ssh/authorized_keys_
	Installed when an SSH key is provided.

_/etc/doas.d/20-wheel.conf_
	Created by the *\-a* option with *permit persist :wheel*.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# SEE ALSO

*adduser*(8), *passwd*(1), *doas*(1), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
