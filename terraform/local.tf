locals {
  op_vault_name = "HomeAutomation"

  pve_node = "pve-01"
  server_ips = {
    bind9-dns      = "10.0.1.1",
    grafana        = "10.0.1.7",
    home-assistant = "10.0.1.8",
    kea-dhcp       = "10.0.1.9",
    mail           = "10.0.1.10",
    network-ups    = "10.0.1.11",
    omada          = "10.0.1.12",
    proxmox-01     = "10.0.1.3",
    step-ca        = "10.0.1.6",
    synology-01    = "10.0.1.4",
    synology-02    = "10.0.1.5",
  }

  server_aliases = {

  }

  qemu_vms = {
    clone = "ubuntu-22.04"
    ubuntu2204 = [
      {
        name         = "omada"
        cores        = 4
        memory       = 4096
        ipconfig0    = "ip=10.0.1.12/24,gw=10.0.1.1"
        vmid         = 3164
        storage_pool = "local-data00"
        disk_size    = "80G"
      },
      {
        name         = "dns"
        cores        = 2
        memory       = 2048
        ipconfig0    = "ip=10.0.1.2/24,gw=10.0.1.1"
        vmid         = 7842
        storage_pool = "local-data00"
        disk_size    = "80G"
      }
    ]
  }
}
