SETUP-DESKTOP(8) "Alpine Linux"

# NAME

*setup-desktop* - install a desktop environment

# SYNOPSIS

*setup-desktop* [\-h] [gnome | plasma | xfce | xfce-wayland | mate | sway | lxqt | none]

# DESCRIPTION

*setup-desktop* installs a standard desktop environment.

The accepted values are listed in the synopsis. The value *none* exits
without changes.

The script installs the required packages for the selected desktop, enables
its display manager and other needed services in the *default* runlevel, and
disables *acpid* if present.

If no user accounts exist (UID >= 1000, UID < 65000), *setup-user* is run
to create one before installing the desktop. A warning is printed if no
users exist after installation.

# OPTIONS

*\-h*
	Display usage information and exit.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# SEE ALSO

*setup-xorg-base*(8), *setup-wayland-base*(8), *setup-user*(8), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
