#!/bin/sh

PREFIX=

PROGRAM=`basename $0`


echon () {
	if [ X"$ECHON" = X ]; then
		# Determine how to "echo" without newline: "echo -n"
		# or "echo ...\c"
		if [ X`echo -n` = X-n ]; then
			ECHON=echo
			NNL="\c"
			# "
		else
			ECHON="echo -n"
			NNL=""
		fi
	fi
	$ECHON "$*$NNL"
}

init_tmpdir() {
	local omask=`umask`
	local __tmpd="/tmp/$PROGRAM-${$}-`date +%s`"
	umask 077 || die "umask"
	mkdir "$__tmpd" || exit 1
	trap "rm -fr \"$__tmpd\"; exit" 0
	umask $omask
	eval "$1=\"$__tmpd\""
}

pkg_inst() {
	[ -z "$NOCOMMIT" ] && apk_add $*
}

pkg_deinst() {
	[ -z "$NOCOMMIT" ] && apk_delete $*
}

default_read() {
	local n
	read n
	[ -z "$n" ] && n="$2"
	eval "$1=\"$n\""
}


invalid_ip() {
	[ "$1" ] || return 0
	! ipcalc -s $1
}


cfg_add() {
	[ -z "$NOCOMMIT" ] && lbu_add "$@"
}
