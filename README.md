Powersave
=========

This is a powersaving script for Linux. Initially, I've created it for my own laptop. That means that this script will **not** work on every setup so please **check** this before running it on your computer! Things might break otherwise and I will **not** be responsible for any damage that has been done. This script gives me roughly 1:30/2:00 hours of battery life, on a battery that would otherwise last ~45 minutes. (yea, I know, my battery is fried)

This script has been modified to work in tandem with [TLP](http://linrunner.de/en/tlp/docs/tlp-linux-advanced-power-management.html), which handles additional power management toggles between battery/AC.

Installation
------------

The script will need the following dependencies to run:
* hdparm
* wireless_tools
* xset
* udev
* udisks

Just run `make install` as root to install the script and the udev rules.

Usage
-----

Once the script is installed, one can run `powersave true | false` and the powersaving will kick in. The udev rule will automatically run these commands depending on the battery state (Charging, discharging). The other udev rule will also enable or disable CD polling by udisks, depending on the battery state.

Configuration
-------------

Things you should edit, should you use this on your setup:
* ASPM powersave; this option is usually safe! To be able to write to this file you may have to use a kernel parameter at boot: `pcie_aspm=force`
  * Note that the thinkpad T440p doesn't support ASPM, so I've removed this, but you should evaluate it on your own.
* Screen powersave; this option is safe! The numbers of brightness differ per manufacturer. You should check yours. Do so by setting your screen on maximum brightness and then running `cat/sys/class/backlight/acpi_video*/brightness`
Then, lookup the `false)` part in the script and change the value. I've got it disabled since I have screen power management enabled even when docked.
* Battery line in the systemd sleep hook, your setup might have a different path.

These modules can be blacklisted to save power:
* btusb
* bluetooth
* uhci_hcd
* pcmcia
* yenta_socket
* ipw2200
* ohci1394
* firewire-ohci

In Arch Linux, add this list to `/etc/modprobe.d/blacklist.conf` to have them all blacklisted at boot.

ToDo
----

* Set more aggressive power savings
 * SATA ALPM (Aggressive power management)
* Add post-dock hooks to re-configure external displays (e.g. invoke randr using the preferred configs or a configured setup)

