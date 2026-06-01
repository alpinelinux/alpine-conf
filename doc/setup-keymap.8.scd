SETUP-KEYMAP(8) "Alpine Linux"

# NAME

*setup-keymap* - set system keyboard layout and variant

# SYNOPSIS

*setup-keymap* [\-h] [_LAYOUT_ [_VARIANT_]]

# DESCRIPTION

*setup-keymap* configures the keyboard layout and variant.

It installs the *kbd-bkeymaps* package, copies the keymap file to
_/etc/keymap/_, writes _KEYMAP_ in _/etc/conf.d/loadkmap_, starts
*loadkmap* and enables it at boot.

_LAYOUT_ and _VARIANT_ can be given as two separate arguments. In interactive
mode, they can also be entered as a single space-separated value (e.g.
*us dvorak*).

When _LAYOUT_ is *none*, no keymap is configured.

If _LAYOUT_ is omitted, the script lists available layouts and prompts for a
selection. After a layout is chosen, it lists available variants and prompts
for one. If only one variant exists, it is selected automatically.

# OPTIONS

*\-h*
	Display usage information and exit.

# INTERACTIVE MODE

Without a _LAYOUT_ argument, the script lists all available layouts from
*/usr/share/bkeymaps/* and prompts:

	Select keyboard layout:

The user can enter a layout name, a layout name followed by a variant, or
*abort* / *none* to exit.

After a layout is selected, available variants for that layout are listed
and the script prompts:

	Select variant (or 'abort'):

The user can enter a variant name, or *abort* / *none* to return to the
layout selection prompt.

Choosing *abort* or *none* at the layout prompt exits the script without
changing the keymap.

# FILES

*/usr/share/bkeymaps/*
	Directory containing keyboard layout and variant files.

_/etc/conf.d/loadkmap_
	loadkmap configuration file. *setup-keymap* sets _KEYMAP_ here.

_/etc/keymap/_
	Directory where the selected keymap file is installed.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred (invalid usage, copy failure).

# SEE ALSO

*loadkmap*(8), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
