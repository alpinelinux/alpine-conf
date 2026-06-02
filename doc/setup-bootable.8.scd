SETUP-BOOTABLE(8) "Alpine Linux"

# NAME

*setup-bootable* - make a device or directory bootable

# SYNOPSIS

*setup-bootable* [\-f] [\-h] [\-k] [\-s] [\-U] [\-u] [\-v] _SOURCE_ [_DEST_]

*setup-bootable* \-c _DIR_

# DESCRIPTION

*setup-bootable* copies _SOURCE_ to _DEST_ and makes _DEST_ bootable.

_SOURCE_ can be a directory, an ISO image, or a URL. _DEST_ defaults to
_/media/usb_ and can be a mounted directory or a block device.

The script copies boot, EFI, APK, syslinux.cfg, and .alpine-release files.
If _DEST_ is a device, the bootloader (syslinux by default on x86) is
installed after the copy.

In check mode (*\-c*), the script inspects and optionally fixes the
syslinux.cfg in _DIR_ without copying or installing anything.

# OPTIONS

*\-c* _DIR_
	Check syslinux.cfg in _DIR_. Use with *\-f* to fix entries.

*\-f*
	Force overwrite of existing files and overwrite syslinux.cfg on
	upgrade.

*\-h*
	Display usage information and exit.

*\-k*
	Fix kernel and initrd names in syslinux.cfg if needed.

*\-s*
	Force running the bootloader even when in upgrade mode.

*\-U*
	Replace *alpine_dev* references in syslinux.cfg with the device
	UUID when a UUID is found.

*\-u*
	Upgrade mode. Keep the existing syslinux.cfg and do not run the
	bootloader.

*\-v*
	Verbose output.

# ENVIRONMENT

*BOOTLOADER*
	Set to *syslinux* or *none*. Defaults to *syslinux* on x86/x86_64
	and *none* on other architectures.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# SEE ALSO

*syslinux*(8), *setup-disk*(8), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
