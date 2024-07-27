#!/usr/bin/env bash

#
# Run this on the Proxmox host to set up the cloud init vendor customizations
# for debian based systems
#

cat <<EOF > /var/lib/vz/snippets/vendor-debian.yaml
#cloud-config
runcmd:
  - apt update
  - apt install -y qemu-guest-agent
  - systemctl start qemu-guest-agent
  - reboot
EOF
