LBU(8) "Alpine Linux"

# NAME

*lbu* - manage local backups for diskless Alpine Linux systems

# SYNOPSIS

*lbu* _SUBCOMMAND_ [_OPTIONS_] [_ARGS_]

# DESCRIPTION

*lbu* manages Alpine local backup overlays. It tracks files to include or
exclude, creates apkovl archives, commits them to removable media or a backup
directory, and compares or reverts saved overlays.

The default file set is provided by the apk backup audit. Additional include
and exclude entries are stored in the lbu protected paths file. Included
entries use a leading "+". Excluded entries use a leading "-".

# SUBCOMMANDS

*include*, *inc*, *add* [\-rv] _FILE_...
	Add files to the include list. Leading "/" characters are stripped before
	entries are stored.

*include*, *inc*, *add* [\-v] *\-l*
	List files in the include list.

*exclude*, *ex*, *delete* [\-rv] _FILE_...
	Add files to the exclude list. If a file is present in the include list,
	it is removed from there.

*exclude*, *ex*, *delete* [\-v] *\-l*
	List files in the exclude list.

*list*, *ls*
	List files that would be written to an apkovl archive.

*package*, *pkg* [\-v] [_DIR_ | _FILE_]
	Create an apkovl archive. If _DIR_ is specified, the archive is written
	there using the default apkovl filename. If _FILE_ is specified and is
	not a directory, that filename is used. With no argument, the archive is
	written to the current directory.

*commit*, *ci* [\-denv] [\-p _PASSWORD_] [_MEDIA_]
	Create an apkovl archive and save it to writable media or
	*$LBU_BACKUPDIR*. If _MEDIA_ is not specified, *LBU_BACKUPDIR* or
	*LBU_MEDIA* is used. If *LBU_BACKUPDIR* is set, no media is mounted.

*list-backup*, *lb* [_MEDIA_]
	List timestamped backup archives from _MEDIA_ or *$LBU_BACKUPDIR*.

*revert* _REVISION_ [_MEDIA_]
	Replace the current apkovl archive with _REVISION_. The current archive
	is backed up before the revision is moved into place.

*status*, *stat*, *st* [\-av]
	Show changes compared with the last committed apkovl. Output is prefixed
	with "A" for added files, "D" for deleted files, and "U" for updated files.

*diff* [_MEDIA_]
	Run a recursive diff between the last committed apkovl and the current
	file set.

# OPTIONS

*\-a*
	For *status*, compare all backup-tracked files instead of comparing
	with the last committed apkovl.

*\-d*
	For *commit*, remove old apkovl files before writing the new archive.

*\-e*
	Enable encryption. If no cipher is configured, *DEFAULT_CIPHER* is used.

*\-h*
	Display help for the selected subcommand.

*\-l*
	For *include* or *exclude*, list entries instead of changing them.

*\-n*
	For *commit*, perform a dry run and show what would be committed.

*\-p* _PASSWORD_
	Use _PASSWORD_ for encryption.

*\-q*
	Quiet mode.

*\-r*
	For *include* or *exclude*, remove files from the selected list.

*\-v*
	Verbose mode.

# CONFIGURATION

Configuration is read from _/etc/lbu/lbu.conf_.

*DEFAULT_CIPHER*
	Cipher used when *\-e* enables encryption. The default is aes-256-cbc.

*ENCRYPTION*
	Encrypt archives with this cipher by default.

*PASSWORD*
	Password used for encryption and decryption.

*LBU_MEDIA*
	Default media name for commands that need backup media. Common values are
	*usb* and *floppy*.

*LBU_BACKUPDIR*
	Directory where apkovl archives are stored. When set, *lbu* does not mount
	backup media.

*BACKUP_LIMIT*
	Number of timestamped previous apkovl archives to keep after *commit*.

# HOOKS

Executable scripts in _/etc/lbu/pre-package.d_ are run before package
creation. Executable scripts in _/etc/lbu/post-package.d_ are run after
package creation.

# EXAMPLES

Add files to the include list:

```
lbu include /root/.ssh
```

Exclude a file from backups:

```
lbu exclude /etc/motd
```

Create an apkovl archive in the current directory:

```
lbu package
```

Commit to the configured backup directory or media:

```
lbu commit
```

Commit to USB media and remove old apkovl files first:

```
lbu commit -d usb
```

Show changes compared with the last commit:

```
lbu status
```

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# FILES

_/etc/lbu/lbu.conf_
	Configuration file.

_/etc/lbu/pre-package.d_
	Directory for scripts run before package creation.

_/etc/lbu/post-package.d_
	Directory for scripts run after package creation.

_/etc/apk/protected_paths.d/lbu.list_
	Include and exclude list maintained by *lbu*.

_/media/MEDIA/HOSTNAME.apkovl.tar.gz_
	Default archive path when committing to media.

# SEE ALSO

*apk*(8), *setup-alpine*(8), *setup-disk*(8), *setup-lbu*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
