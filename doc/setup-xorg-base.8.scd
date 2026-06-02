SETUP-XORG-BASE(8) "Alpine Linux"

# NAME

*setup-xorg-base* - set up system for Xorg

# SYNOPSIS

*setup-xorg-base* [\-h] [_\PKG ..._]

# DESCRIPTION

*setup-xorg-base* prepares a system for X11-based graphical environments.
It enables community package repositories, installs *xorg-server*,
*xf86-input-libinput*, *xinit*, *eudev*, and *mesa-dri-gallium*, and
configures udev (via *setup-devd*).

Additional packages given as arguments are installed alongside the Xorg
packages.

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
