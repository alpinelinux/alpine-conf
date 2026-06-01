SETUP-APKREPOS(8) "Alpine Linux"

# NAME

*setup-apkrepos* - configure apk package repositories

# SYNOPSIS

*setup-apkrepos* [\-ch] [\-f | \-r | \-1 | _REPO_...]

*setup-apkrepos* \-o

# DESCRIPTION

*setup-apkrepos* configures _/etc/apk/repositories_. It can add a mirror from
the Alpine mirror list, write explicit repository URLs, enable matching
community repositories, or prompt interactively.

When a mirror is selected from the mirror list, repositories are written for
the current Alpine release. The release is inferred from an existing main
repository or from _/etc/alpine-release_; development and unknown versions
fall back to *edge*.

After changing repositories, the script runs *apk update*.

# OPTIONS

*\-1*
	Add the first mirror from the mirror list, normally the CDN mirror, and
	do not prompt.

*\-c*
	Enable the community repository when adding a mirror. Without this option,
	the generated community repository line is commented out.

*\-f*
	Find and add the fastest mirror from the mirror list, and do not prompt.

*\-h*
	Display usage information and exit.

*\-o*
	Only enable a community repository for every main repository
	already configured in _/etc/apk/repositories_.

*\-r*
	Add a random mirror from the mirror list, and do not prompt.

_REPO_...
	Replace _/etc/apk/repositories_ with the specified repository lines.

*\-o* cannot be used with *\-c*, *\-f*, *\-r*, or *\-1*.

*\-f*, *\-r*, and *\-1* are mutually exclusive.

# INTERACTIVE MODE

Without non-interactive options or explicit _REPO_ arguments, the script
prompts for a setup method. The prompt accepts:

*f*
	Find and use the fastest mirror.

*s*
	Show the mirror list.

*r*
	Use a random mirror.

*e*
	Edit _/etc/apk/repositories_ with _EDITOR_ or *vi*.

*c*
	Toggle whether generated mirror entries enable the community repository.

*skip*
	Exit without changing repositories.

number
	Add the numbered mirror from the mirror list.

URL or path
	Add the specified repository URL or absolute path.

Adding *c* after answers such as *f c* or *r c* enables community
repositories.

# ENVIRONMENT

*MIRRORS_URL*
	URL used to fetch the Alpine mirror list. The default is
	_https://mirrors.alpinelinux.org/mirrors.txt_.

*MIRRORS*
	Whitespace-separated mirror list. If set, *setup-apkrepos* uses this list
	instead of fetching *MIRRORS_URL*.

*APKREPO_DEFAULT_ANSWER*
	Default answer used by the interactive prompt.

*EDITOR*
	Editor used by the interactive edit command. Defaults to *vi*.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# FILES

_/etc/apk/repositories_
	apk repository configuration file.

_/etc/alpine-release_
	Alpine release file used to choose the repository release.

# SEE ALSO

*apk*(8), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
