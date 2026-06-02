SETUP-WAYLAND-BASE(8) "Alpine Linux"

# NAME

*setup-wayland-base* - set up system for Wayland

# SYNOPSIS

*setup-wayland-base* [\-h] [_\PKG ..._]

# DESCRIPTION

*setup-wayland-base* prepares a system for Wayland-based graphical
environments. It enables community package repositories, installs
elogind and polkit-elogind, configures udev (via *setup-devd*), and
enables and starts the *cgroups* and *dbus* services.

Additional packages given as arguments are installed alongside elogind.

# OPTIONS

*\-h*
	Display usage information and exit.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# SEE ALSO

*setup-devd*(8), *setup-apkrepos*(8), *setup-desktop*(8), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
