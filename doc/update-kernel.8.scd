UPDATE-KERNEL(8) "Alpine Linux"

# NAME

*update-kernel* - update kernel, modules and firmware

# SYNOPSIS

*update-kernel* [\-a _ARCH_] [\-b _BUILDDIR_] [\-c _CACHEDIR_] [\-C _COMPRESSION_] [\-d _KEYSDIR_] [\-e _FIRMWARE_] [\-f _FLAVOR_] [\-F _FEATURE_] [\-h] [\-k _PUBKEY_] [\-K] [\-M] [\-p _PACKAGE_] [\-s] [\-v] [_\DESTDIR_]

# DESCRIPTION

*update-kernel* installs or updates kernel, kernel modules, and firmware
in a destination directory for an Alpine installation. It supports
downloading pre-built kernels by flavor or installing custom-built kernels
from a build directory.

The script creates a modloop squashfs image containing modules and firmware,
builds an initramfs, and copies the kernel image, System.map, and config
to the destination.

On systems where the modloop is mounted, the destination is auto-detected
from the modloop mount. Without any arguments, the script updates the
current running kernel.

# OPTIONS

*\-a*, *\--arch* _ARCH_
	Target architecture (e.g. x86_64, aarch64).

*\-b*, *\--build-dir* _DIR_
	Install a custom-built kernel from _DIR_. Mutually exclusive with
	*\-f*.

*\-c*, *\--cache-dir* _DIR_
	Override the apk cache directory. Default: _/etc/apk/cache_.

*\-C*, *\--compression*
	Initramfs compression method (see *mkinitfs*).

*\-d*, *\--keys-dir* _DIR_
	Override the trusted apk keys directory.

*\-e*, *\--modloopfw* _FIRMWARE_
	Install extra firmware file in the modloop, in addition to firmware
	detected by *modinfo*.

*\-f*, *\--flavor* _FLAVOR_
	Install kernel of specified flavor (e.g. *virt*, *lts*). Mutually
	exclusive with *\-b*.

*\-F*, *\--feature* _FEATURE_
	Enable an initfs feature. Defaults to features from
	_/etc/mkinitfs/mkinitfs.conf_.

*\-h*, *\--help*
	Display usage information and exit.

*\-k*, *\--apk-pubkey* _FILE_
	Include the given apk public key in the initramfs.

*\-K*, *\--hostkeys*
	Include host keys in the initramfs.

*\-M*, *\--media*
	Boot media directory layout.

*\-p*, *\--package* _PACKAGE_
	Additional module or firmware package to install.

*\-s*, *\--modloopsign*
	Sign the modloop with the abuild signing key.

*\-v*, *\--verbose*
	Verbose output.

*\--repositories-file* _FILE_
	Override the apk repositories file. Default:
	_/etc/apk/repositories_.

# ENVIRONMENT

*TMPDIR*
	Point to a storage-backed directory on low-memory systems.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# SEE ALSO

*mkinitfs*(8), *mksquashfs*(1), *apk*(8), *setup-bootable*(8),
*setup-alpine*(8)

# AUTHORS

Timo Teras, Kaarle Ritvanen, Natanael Copa, and others
