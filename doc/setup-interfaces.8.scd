SETUP-INTERFACES(8) "Alpine Linux"

# NAME

*setup-interfaces* - configure Alpine Linux network interfaces

# SYNOPSIS

*setup-interfaces* [\-abhir] [\-p _ROOT_] [\-w _FILE_]

# DESCRIPTION

*setup-interfaces* configures network interfaces for Alpine Linux. It provides
an interactive walk-through that detects unconfigured interfaces and prompts
for addressing, bridges, bonding, VLANs, and wireless credentials.

It writes network configuration under the target root and optionally sets up
_wpa_supplicant_(8) for wireless networks.

When run in a Xen Dom0, bridging is offered by default.

# OPTIONS

*\-a*
	Set up the first available interface with DHCP and exit. No prompts
	are shown. All available interfaces are brought up and polled
	simultaneously; the first whose link state becomes "up" (within a
	total timeout of roughly 1.1 seconds) is configured, and the rest
	are taken down.

*\-b*
	Prompt for bridging of each interface during interactive setup.
	Enabled by default in Xen Dom0.

*\-h*
	Display usage information and exit.

*\-i*
	Read new contents of _/etc/network/interfaces_ from stdin and write
	them to the file. No interactive prompts are shown. When combined
	with *\-a*, *\-i* takes precedence.

*\-p* _ROOT_
	Operate on the system tree at _ROOT_ instead of "/". Network and
	imported wireless configuration are written under _ROOT_.

*\-r*
	Restart the networking service after configuration.

*\-w* _FILE_
	Import _FILE_ as _/etc/wpa_supplicant/wpa_supplicant.conf_ and
	enable the wpa_supplicant service at boot. Can be combined with
	other modes to set up wireless credentials alongside the interface
	configuration.

# INTERACTIVE MODE

When invoked without *\-a* or *\-i*, *setup-interfaces* enters
interactive mode.

## Interface selection

The script scans for unconfigured interfaces (physical network devices that
are not already set up in _/etc/network/interfaces_). The loopback and
docker0 are skipped. For each detected interface, the user is prompted to
assign it an address, add it to a bridge or bond, or mark it as a VLAN raw
device.

The following interface types can be entered at the prompt:

*br[0-9]+* (e.g. br0)
	Bridge interface. The script prompts for which unconfigured
	physical ports to add as bridge ports.

*bridge[0-9]+* (e.g. bridge0)
	Synonym for a bridge interface.

*virbr[0-9]+* (e.g. virbr0)
	Bridge interface.

*bond[0-9]+* (e.g. bond32)
	Bonded (aggregated) interface. The script prompts for which
	unconfigured physical interfaces to add as bond slaves.

*bond[0-9]+.[0-9]+* (e.g. bond0.371)
	VLAN on top of a bonded interface.

*vlan[0-9]+* (e.g. vlan371)
	VLAN interface. The script prompts for the raw device.

*IFACE.[0-9]+* (e.g. eth0.371)
	VLAN on a physical interface.

## Addressing

For each interface, the following address types are supported:

*dhcp*
	Configure the interface with DHCP.

*static*
	Enter a static IPv4 address. A prompt for netmask (default
	_255.255.255.0_) and gateway (default _none_) follows.

*none*
	Do not assign an address. An "up" entry is written to the config
	so the interface is brought up at boot.

When a static address is entered with a /mask suffix (e.g.
_192.168.1.1/24_), the netmask is extracted automatically and the netmask
prompt is skipped.

## Wireless

If the interface is a wireless device (has a _phy80211_ directory under
_/sys/class/net/_), the script scans for visible access points and prompts
for the SSID. For WPA-PSK networks, a password is prompted. The
configuration is written via *wpa_passphrase*(8) to
_/etc/wpa_supplicant/wpa_supplicant.conf_, and the wpa_supplicant service is
enabled and started.

The _iw_ and _wpa_supplicant_ packages are installed on demand.

## Bridge, bond, and VLAN details

Bridges and bonds collect ports from the pool of unconfigured physical
interfaces. Once a port is assigned to a bridge or bond, it is removed from
the unconfigured pool and is not prompted for individually.

VLAN interfaces (e.g. eth0.371) require a raw device; the raw device must
itself be unconfigured or a bond master.

## Final steps

After all interfaces are configured, the user is offered an opportunity to
edit the generated configuration manually. If packages for bridging (bridge),
bonding (bonding), or VLANs (vlan) are needed, they are installed. The
configuration is then copied to _/etc/network/interfaces_.

# EXIT STATUS

0
	Success.

non-zero
	An error occurred.

# ENVIRONMENT

*SETUP_INTERFACES_LINK_WAIT_MAX*
	Maximum number of retries (at 0.1-second intervals) when waiting for
	a link to come up in *\-a* mode. Defaults to 11 (approximately 1.1
	seconds total).

# FILES

_/etc/network/interfaces_
	Generated network interface configuration file.

_/etc/wpa_supplicant/wpa_supplicant.conf_
	wpa_supplicant configuration written when wireless networks are
	configured.

# SEE ALSO

*wpa_supplicant*(8), *wpa_passphrase*(8), *setup-alpine*(8), *setup-disk*(8)

# AUTHORS

Natanael Copa <_ncopa@alpinelinux.org_> and others
