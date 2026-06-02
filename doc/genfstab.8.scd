GENFSTAB(8) "Alpine Linux"

# NAME

*genfstab* - generate fstab entries from mounted filesystems

# SYNOPSIS

*genfstab* [\-h] [\-U] _ROOT_

# DESCRIPTION

*genfstab* reads _/proc/mounts_ and generates fstab output for filesystems
mounted below _ROOT_.

Pseudo filesystems (proc, sysfs, devtmpfs, cgroup, and similar) are
excluded from the output.

With *\-U*, device paths are replaced with UUID identifiers where
available. MD devices and devices listed in the *NO_DISK_UUID* environment
variable are not converted.

# OPTIONS

*\-h*
	Display usage information and exit.

*\-U*
	Use UUIDs instead of device paths.

# ENVIRONMENT

*NO_DISK_UUID*
	Space-separated list of devices that should not use UUIDs.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# SEE ALSO

*fstab*(5), *blkid*(8), *mount*(8), *setup-disk*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
