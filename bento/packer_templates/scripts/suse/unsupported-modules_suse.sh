#!/bin/sh

# Enable unsupported kernel modules, so vboxguest can install
echo 'allow_unsupported_modules 1' > /etc/modprobe.d/10-unsupported-modules.conf
