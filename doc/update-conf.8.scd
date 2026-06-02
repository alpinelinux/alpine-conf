UPDATE-CONF(8) "Alpine Linux"

# NAME

*update-conf* - interactively update configuration files

# SYNOPSIS

*update-conf* [\-a] [\-h] [\-i] [\-l]

# DESCRIPTION

*update-conf* finds all *\&.apk-new* files under _/etc_, compares them with
the installed versions, and interactively prompts the user for each changed
file.

For each file, the user can quit, skip, show a diff, edit the new file,
delete it, or replace the installed version.

Unchanged files (not modified by the user and not listed in lbu status) are
updated automatically.

# OPTIONS

*\-a*, *\--all*
	Select all updated files, including unmodified ones.

*\-h*, *\--help*
	Display usage information and exit.

*\-i*, *\--initd*
	Automatically accept new init.d scripts.

*\-l*, *\--list*
	List updated files without prompting.

# INTERACTIVE COMMANDS

*n*
	Skip to the next file.

*s*
	Show diff (using *\&$PAGER* or *less*).

*e*
	Edit the new file (using *\&$EDITOR* or *vi*).

*v*
	Vimdiff old and new.

*z*
	Delete the *\&.apk-new* file.

*u*
	Replace the installed file with the new one.

*q*
	Quit.

# EXIT STATUS

0
	Success.

# SEE ALSO

*lbu*(8), *apk*(8), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
