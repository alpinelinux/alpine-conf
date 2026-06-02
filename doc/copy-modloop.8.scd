COPY-MODLOOP(8) "Alpine Linux"

# NAME

*copy-modloop* - copy kernel modules from modloop

# SYNOPSIS

*copy-modloop* [\-h]

# DESCRIPTION

*copy-modloop* copies kernel modules from the modloop loopback device to
_/lib/modules_ and unmounts the modloop. It is typically used on Alpine
Live ISO images to make the kernel modules persistent after a disk
installation.

The modloop service must be running when the script starts. The script
stops the modloop service after copying the modules.

# OPTIONS

*\-h*
	Display usage information and exit.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred, or the modloop service was not started.

# SEE ALSO

*modloop*(8), *setup-disk*(8), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
