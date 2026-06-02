SETUP-XEN-DOM0(8) "Alpine Linux"

# NAME

*setup-xen-dom0* - configure a Xen dom0 host

# SYNOPSIS

*setup-xen-dom0* [_PKG ..._]

# DESCRIPTION

*setup-xen-dom0* prepares the system as a Xen dom0 host. It loads kernel
modules for Xen backend drivers, installs the *xen* package (with any
additional packages given as arguments), and enables and starts the Xen
management services.

The following kernel modules are loaded and persisted to _/etc/modules_:

xen_netback, xen_blkback, xenfs, xen_pciback, xen_wdt, tun

The following services are enabled in the *default* runlevel and started:

xenstored, xenconsoled, xenqemu

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# SEE ALSO

*xl*(1), *xen*(1), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
