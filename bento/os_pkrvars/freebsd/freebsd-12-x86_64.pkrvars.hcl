os_name                 = "freebsd"
os_version              = "12.4"
os_arch                 = "x86_64"
iso_url                 = "https://download.freebsd.org/releases/amd64/amd64/ISO-IMAGES/12.4/FreeBSD-12.4-RELEASE-amd64-disc1.iso"
iso_checksum            = "606435637b76991f96df68f561badf03266f3d5452e9f72ed9b130d96b188800"
parallels_guest_os_type = "freebsd"
vbox_guest_os_type      = "FreeBSD_64"
vmware_guest_os_type    = "freebsd-64"
boot_command            = ["<wait><esc><wait>boot -s<wait><enter><wait><wait10><wait10>/bin/sh<enter><wait>mdmfs -s 100m md1 /tmp<enter><wait>mdmfs -s 100m md2 /mnt<enter><wait>dhclient -p /tmp/dhclient.em0.pid -l /tmp/dhclient.lease.em0 em0<enter><wait>fetch -o /tmp/installerconfig http://{{ .HTTPIP }}:{{ .HTTPPort }}/freebsd/installerconfig \u0026\u0026 bsdinstall script /tmp/installerconfig<enter><wait>"]
