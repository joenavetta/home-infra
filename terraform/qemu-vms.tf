resource "proxmox_vm_qemu" "ubuntu2204" {
  target_node = local.pve_node

  for_each = {for i, v in local.qemu_vms.ubuntu2204 : i => v}

  agent                  = 1
  boot                   = "order=scsi0"
  clone                  = local.qemu_vms.clone
  cores                  = each.value.cores
  cpu                    = "host"
  define_connection_info = false
  full_clone             = false
  ipconfig0              = each.value.ipconfig0
  memory                 = each.value.memory
  name                   = each.value.name
  scsihw                 = "virtio-scsi-pci"
  tablet                 = true
  vm_state               = "running"
  vmid                   = each.value.vmid
  protection             = true

  disks {
    ide {
      ide0 {
        cdrom {
          passthrough = false
        }
      }
      ide2 {
        cloudinit {
          storage = each.value.storage_pool
        }
      }
    }
    scsi {
      scsi0 {
        disk {
          size    = each.value.disk_size
          storage = each.value.storage_pool
        }
      }
    }
  }

  lifecycle {
    prevent_destroy = true
    ignore_changes = [
      cicustom, network, sshkeys
    ]
  }
}
