SETUP-DISK(8) "Alpine Linux"

# NAME

*setup-disk* - install Alpine Linux to disk or mounted root

# SYNOPSIS

*setup-disk* [\-hLqrve] [\-b _DISKDEV_] [\-k _KERNELFLAVOR_] [\-m _MODE_]

*setup-disk* [\-o _APKOVL_] [\-R _ROOT_SIZE_] [\-s _SWAP_SIZE_] [\-w _FILE_]

*setup-disk* [_MOUNTPOINT_ | _DISKDEV_...]

# DESCRIPTION

*setup-disk* installs Alpine Linux to a mounted root or prepares one or more
block devices for a system or data-only installation.

If _MOUNTPOINT_ is specified, *setup-disk* installs Alpine Linux into a
mounted root and configures bootloader support.

With disk device arguments, disks are partitioned and formatted without
prompting. Multiple disks are configured as a software RAID array. Two disks
use RAID1; more than two disks use RAID5.

If no target is specified, *setup-disk* lists available disks and prompts
for the target disk and install mode.

The selected disk devices are erased.

# MODES

*sys*
	Perform a traditional disk install. The target disk is used for the
	operating system and normally receives boot, root, and swap storage.

*data*
	Use the target disk for persistent data storage while the operating
	system continues to run from tmpfs.

*crypt*
	Enable encryption and prompt again for *sys* or *data* mode.

*cryptsys*
	Use *sys* mode with encryption enabled.

*lvm*
	Enable LVM and prompt again for *sys* or *data* mode.

*lvmsys*
	Use *sys* mode with LVM enabled.

*lvmdata*
	Use *data* mode with LVM enabled.

*none*
	Exit without installing to disk.

# OPTIONS

*\-b* _DISKDEV_
	Install the bootloader to _DISKDEV_ when installing to a mounted root.
	This option may be specified multiple times.

*\-e*
	Encrypt the disk using LUKS.

*\-h*
	Display usage information and exit.

*\-k* _KERNELFLAVOR_
	Use _KERNELFLAVOR_ instead of the detected kernel flavor.

*\-L*
	Use LVM to manage partitions.

*\-m* _MODE_
	Use _MODE_ without prompting. Valid non-interactive modes are *sys*,
	*data*, and *none*.

*\-o* _APKOVL_
	Restore the system from the specified apkovl file.

*\-q*
	Exit quietly if no disks are found.

*\-r*
	Enable software RAID1 with a single disk.

*\-R* _ROOT_SIZE_
	Use _ROOT_SIZE_ MB for the root filesystem instead of maximizing its
	size.

*\-s* _SWAP_SIZE_
	Use _SWAP_SIZE_ MB for swap instead of autodetecting the swap size.
	Use *0* to disable swap.

*\-v*
	Print more information about what is happening.

*\-w* _FILE_
	Write the selected install mode to _FILE_.

# ENVIRONMENT

*BOOTLOADER*
	Select the bootloader. Supported values are *grub*, *syslinux*,
	*zipl*, *raspberrypi-bootloader*, *u-boot*, *limine*, and *none*.
	If unset, a default is selected from the architecture and boot
	environment.

*BOOTFS*, *ROOTFS*, *VARFS*
	Select filesystems for boot, root, and var storage. The default is
	*ext4*. Supported boot filesystems are *ext2*, *ext3*, *ext4*,
	*btrfs*, *xfs*, and *vfat* for EFI. Root and var support the same
	list except *vfat*.

*DISKLABEL*
	Select the partition label. Supported values are *dos* and *gpt*.
	The default is *dos*, except EFI installations use *gpt*. ECKD DASD
	disks use *eckd* automatically.

*KERNELOPTS*
	Append kernel boot parameters. The default is *quiet*.

*DEFAULT_DISK*
	Device name proposed by default in interactive disk selection.

*ERASE_DISKS*
	Space-separated full device paths that may be processed without the
	confirmation dialog.

*USE_EFI*
	Force EFI behavior. This selects *gpt* partitioning and a *vfat* boot
	filesystem.

# EXAMPLES

Install to */dev/sda* in system mode:

```
setup-disk -m sys /dev/sda
```

Install to */dev/sda* without swap:

```
setup-disk -m sys -s 0 /dev/sda
```

Install to two disks using RAID:

```
setup-disk -m sys /dev/sda /dev/sdb
```

Install into a mounted root and install the bootloader to */dev/sda*:

```
setup-disk -b /dev/sda /mnt
```

Use Limine as the bootloader:

```
BOOTLOADER=limine setup-disk -m sys /dev/sda
```

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# SEE ALSO

*lbu*(8), *setup-alpine*(8), *setup-bootable*(8), *setup-lbu*(8),
*setup-apkcache*(8), *update-kernel*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
