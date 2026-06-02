SETUP-DEVD(8) "Alpine Linux"

# NAME

*setup-devd* - configure the device manager

# SYNOPSIS

*setup-devd* [\-h] [\-C] [mdev | mdevd | udev]

# DESCRIPTION

*setup-devd* selects and configures the device manager for */dev*. It
disables any other configured device managers and enables the chosen one.

*mdev* (from busybox) is the default. *mdevd* is a standalone, mdev-compatible
alternative. *udev* (from eudev) is the full-featured one.

When a device manager is specified as an argument, the script runs
non-interactively. Without an argument, it prompts for a choice and also asks
whether to coldplug the hardware.

# OPTIONS

*\-C*
	Request a coldplug scan where supported. For *mdevd*, this starts
	*mdevd-init* and *hwdrivers* after *mdevd*. *mdev* and *udev*
	setup do not vary based on this flag. In interactive mode the user
	is asked whether to coldplug; this flag forces that answer.

*\-h*
	Display usage information and exit.

# DEVICE MANAGERS

*mdev*
	Installs *busybox-mdev-openrc*. Enables the *mdev* and *hwdrivers*
	services in the *sysinit* runlevel and starts them.

*mdevd*
	Installs *mdevd* and *mdevd-openrc*, enables mdevd, mdevd-init and
	*hwdrivers* in the *sysinit* runlevel, starts the services and
	performs coldplug if requested.

*udev*
	Installs *eudev*, *udev-init-scripts*, and
	*udev-init-scripts-openrc*. Enables *udev*, *udev-trigger*,
	*udev-settle* in the *sysinit* runlevel and *udev-postmount* in the
	*default* runlevel. Starts all services.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# SEE ALSO

*mdev*(8), *mdevd*(8), *udev*(7), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
