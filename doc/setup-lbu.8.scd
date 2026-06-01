SETUP-LBU(8) "Alpine Linux"

# NAME

*setup-lbu* - configure local backup media for lbu

# SYNOPSIS

*setup-lbu* [\-hq] [_MEDIA_]

# DESCRIPTION

*setup-lbu* configures where *lbu*(8) stores apkovl archives. It sets
*LBU_MEDIA* in _/etc/lbu/lbu.conf_ and adds a corresponding entry to
_/etc/fstab_ if missing.

_MEDIA_ can be a plain name (e.g. *usb*), a path under */media* (e.g.
*/media/usb*), a filesystem label (*LABEL=*_label_), or a UUID
(*UUID=*_uuid_). For a label or UUID, a mount point is created under
*/media*.

When _MEDIA_ is *none*, the script exits without changes.

Without _MEDIA_, the script scans */media* for mounted (non-iso9660)
devices and checks for a filesystem labeled *APKOVL*.
It then prompts the user to choose.

# OPTIONS

*\-h*
	Display usage information and exit.

*\-q*
	Quiet mode. Automatically selects a mounted media suggestion when
	available. Prompts the user when the choice is still uncertain.

# INTERACTIVE MODE

Without a _MEDIA_ argument, the script scans */media* for mounted
(non-iso9660) devices and for a filesystem labeled *APKOVL*. The first
mounted device is offered as the default.

The prompt accepts:

_MEDIA_
	A media mount point name, such as *usb* or *sda1*. The directory
	_/media/_MEDIA_ must exist.

*none*
	Exit without configuring backup media.

_LABEL_\=_label_
	Select media by filesystem label.

# FILES

_/etc/lbu/lbu.conf_
	lbu configuration file. *setup-lbu* sets *LBU_MEDIA* here.

_/etc/fstab_
	Filesystem table. A *noauto*,*ro* entry is added for the media if one
	does not already exist.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred (invalid media, missing device, missing
	filesystem type).

# SEE ALSO

*lbu*(8), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
