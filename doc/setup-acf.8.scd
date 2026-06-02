SETUP-ACF(8) "Alpine Linux"

# NAME

*setup-acf* - install and configure ACF web interface

# SYNOPSIS

*setup-acf* [\-a] [\-e _EMAIL_] [\-h] [\-l _ADDRESS_] [\-n] [_\PACKAGE ..._]

# DESCRIPTION

*setup-acf* installs and configures the Alpine Configuration Framework web
interface. It installs *mini_httpd*, ACF packages, generates SSL
certificates, and sets up the mini_httpd service.

# OPTIONS

*\-a*
	Install all available *acf-* packages.

*\-e* _EMAIL_
	Email address for the SSL certificate subject.

*\-h*
	Display usage information and exit.

*\-l* _ADDRESS_
	Bind address for mini_httpd.

*\-n*
	Skip interactive password creation.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# SEE ALSO

*mini_httpd*(8), *acf-core*(8), *setup-alpine*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
