eckd_dasd=
fba_dasd=

_dasdfmt() {
	local block="$(ls "${ROOT}sys/bus/ccw/devices/$1/block" 2>/dev/null)"
	local dev="${ROOT}dev/$block"
	if ! [ -b "$dev" ]; then
		echo "$dev ($1) is not a block device" >&2
	else
		if ask_yesno "WARNING: Erase ECKD DASD $1? (y/n)" "n"; then
			dasdfmt -b 4096 -d cdl -yp "$dev"
		fi
	fi
}

eckdselect_help() {
	cat <<-__EOF__

		Enter each available DASD's address (e.g. 0.0.02d0) to format that DASD.
		Enter multiple addresses separated by a space to format multiple DASDs.
		Enter 'all' to format all available DASDs.

		WARNING: Data will be lost after formatted!

		Enter 'done' or 'none' to finish formatting.
		Enter 'abort' to quit the installer.

	__EOF__
}

show_dasd_info() {
	local busid= vendor= block= devtype= cutype=
	for busid in $@; do
		vendor=$(cat "${ROOT}sys/bus/ccw/devices/$busid/vendor" 2>/dev/null)
		devtype=$(cat "${ROOT}/sys/bus/ccw/devices/$busid/devtype" 2>/dev/null)
		cutype=$(cat "${ROOT}/sys/bus/ccw/devices/$busid/cutype" 2>/dev/null)
		block="$(ls "${ROOT}/sys/bus/ccw/devices/$busid/block" 2>/dev/null)"
		echo "  $busid	($devtype $cutype $vendor)"
	done
}

ask_eckd(){
	local prompt="$1"
	local help_func="$2"
	shift 2
	local default_dasd="all"
	apk add --quiet s390-tools

	resp=
	while ! all_in_list "$resp" $@ "$default_dasd" "abort" "done" "none"; do
		echo "Available ECKD DASD(s) are:"
		show_dasd_info "$@"
		ask "$prompt" "$default_dasd"
		case "$resp" in
			'abort') exit 0;;
			'done'|'none') return 0;;
			'?') $help_func;;
			'all') for busid in $@; do _dasdfmt $busid; done;;
			*) for busid in $resp; do _dasdfmt $busid; done;;
		esac
	done
}

check_dasd() {
	eckd_dasd= fba_dasd=
	local dasd="$(get_bootopt dasd)"
	for _dasd in $( echo $dasd | tr ',' ' '); do
		[ -e "${ROOT}/sys/bus/ccw/drivers/dasd-eckd/$_dasd" ] && eckd_dasd="$eckd_dasd $_dasd"
		[ -e "${ROOT}/sys/bus/ccw/drivers/dasd-fba/$_dasd" ] && fba_dasd="$fba_dasd $_dasd"
	done
	if [ -n "$eckd_dasd" ]; then
		ask_eckd \
			"Which ECKD DASD(s) would you like to be formatted using dasdfmt? (enter '?' for help)" \
			eckdselect_help "$eckd_dasd"
	fi
}

is_dasd() {
	local disk="${1#*\/dev\/}" dasd_type="$2"
	for _dasd in $(eval "echo \$${dasd_type}_dasd"); do
		[ -e "${ROOT}sys/bus/ccw/drivers/dasd-$dasd_type/$_dasd/block/$disk" ] && return 0
	done
	return 1
}

setup_zipl() {
	local mnt="$1" root="$2" modules="$3" kernel_opts="$4"
	local parameters="root=$root modules=$modules $kernel_opts"
	local dasd="$(echo $eckd_dasd $fba_dasd | tr ' ' ',')"
	local s390x_net="$(get_bootopt s390x_net)"
	[ -n "$dasd" ] && parameters="$parameters dasd=$dasd"
	[ -n "$s390x_net" ] && parameters="$parameters s390x_net=$s390x_net"

	cat > "$mnt"/etc/zipl.conf <<- EOF
	[defaultboot]
	defaultauto
	prompt=1
	timeout=5
	default=linux
	target=/boot
	[linux]
	image=/boot/vmlinuz-$KERNEL_FLAVOR
	ramdisk=/boot/initramfs-$KERNEL_FLAVOR
	parameters="$parameters"
	EOF
}

setup_partitions_eckd() {
	local blocks_per_track=12 tracks_per_cylinder=15 boot_track= swap_track=
	local diskdev="$1" boot_size="$2" swap_size="$3" sys_type="$4"
	boot_track=$(($boot_size * 1024 / 4 / blocks_per_track))
	[ "$swap_size" != 0 ] && swap_track=$(($swap_size * 1024 / 4 / blocks_per_track + boot_track + 1))
	local conf="$(mktemp)"

	if [ -n "$swap_track" ]; then
		cat > "$conf" <<- EOF
		[first,$boot_track,native]
		[$((boot_track + 1)),$swap_track,swap]
		[$((swap_track + 1)),last,$sys_type]
		EOF
	else
		cat > "$conf" <<- EOF
		[first,$boot_track,native]
		[$((boot_track + 1)),last,$sys_type]
		EOF
	fi
	fdasd -s -c "$conf" $diskdev
	rm $conf
}
