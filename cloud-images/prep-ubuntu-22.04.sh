#!/usr/bin/env bash

VM_IMAGE=/var/lib/vz/template/iso/jammy-server-cloudimg-amd64.img
VM_PUBLIC_KEY=/var/lib/vz/snippets/vm-template-key.pub
VM_ID=9101
VM_STORAGE_POOL="local-data00"
VM_NAME="ubuntu-22.04"

qm create $VM_ID --memory 1024 --net0 virtio,bridge=vmbr0 --scsihw virtio-scsi-pci

qm set $VM_ID --scsi0 ${VM_STORAGE_POOL}:0,import-from=${VM_IMAGE}
qm set $VM_ID --name $VM_NAME
qm set $VM_ID --agent enabled=1,fstrim_cloned_disks=1
qm set $VM_ID --ide0 file=none
qm set $VM_ID --ide2 $VM_STORAGE_POOL:cloudinit
qm set $VM_ID --boot order=scsi0
qm set $VM_ID --ostype l26
qm set $VM_ID --serial0 socket --vga serial0
qm set $VM_ID --cpu cputype=host
qm set $VM_ID --sshkeys $VM_PUBLIC_KEY
qm set $VM_ID --cicustom "vendor=local:snippets/vendor-debian.yaml"

qm template $VM_ID
