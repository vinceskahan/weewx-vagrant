
## building vagrant vm of weewx v5

this is for vagrant/Parallels on a m1 mac, but see the
README files below for how to run on intel via VirtualBox

### about this clone of 'bento' from upstream
bento is how to build modified vagrant images with packer

This copy of bento was git cloned on 12/23/2023 and then lightly
edited to work with the images below is here so I don't lose it.
Upstream versions may have evolved since then.

I would 'strongly' suggest you use the official copy of bento
from the nice folks who provide it upstream....

### image names

My custom images via bento are named:
   * almalinux-9.3-aarch64/20231220  (parallels, 0)
   * debian-12.4-aarch64/20231220    (parallels, 0)
   * opensuse-15.5-aarch64/20231220  (parallels, 0)
   * ubuntu-22.04.3-aarch64/20231220 (parallels, 0)

### bento quickstart

```
(setup)
brew install packer
git clone https://github.com/chef/bento.git
cd bento

(build alma-9.3 for mac/parallels)
packer build -only=parallels-iso.vm -var-file=os_pkrvars/almalinux/almalinux-9-aarch64.pkrvars.hcl ./packer_templates
vagrant box add ./packer_templates/../builds/almalinux-9.3-aarch64.parallels.box --name bento/alma-9.3-aarch64
```

