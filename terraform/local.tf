locals {
  one_password = {
    vault_name = "HomeAutomation"
  }

  network = {
    gateway   = "10.0.1.1",
    cidr_bits = 18
    prefix    = "10.0.0.0/18"
    netmask   = "255.255.192.0"
  }

  dns = {
    a_records = {
      dns           = "10.0.1.1",
      proxmox-01    = "10.0.1.3",
      ca            = "10.0.1.6",
      synology-01   = "10.0.1.4",
      synology-02   = "10.0.1.5",
      monitor       = "10.0.1.7",
      homeassistant = "10.0.1.8",
      dhcp          = "10.0.1.9",
      mail          = "10.0.1.10",
      ups           = "10.0.1.11",
      omada         = "10.0.1.12",
      postgres      = "10.0.1.13",
    }

    cname_records = {

    }
  }

  proxmox = {
    node = "proxmox-01"
  }

  vms = [
    {
      name         = "omada"
      clone        = "ubuntu-22.04"
      cores        = 4
      memory       = 4096
      ipconfig0 = format("ip=%s/%d,gw=%s", local.dns.a_records["omada"], local.network.cidr_bits, local.network.gateway)
      vmid         = 3164
      storage_pool = "local-data00"
      disk_size    = "80G"
    },
    {
      name         = "dns"
      clone        = "ubuntu-22.04"
      cores        = 2
      memory       = 2048
      ipconfig0 = format("ip=%s/%d,gw=%s", local.dns.a_records["dns"], local.network.cidr_bits, local.network.gateway)
      vmid         = 7842
      storage_pool = "local-data00"
      disk_size    = "80G"
    },
    {
      name         = "dhcp"
      clone        = "ubuntu-22.04"
      cores        = 2
      memory       = 2048
      ipconfig0 = format("ip=%s/%d,gw=%s", local.dns.a_records["dhcp"], local.network.cidr_bits, local.network.gateway)
      vmid         = 2039
      storage_pool = "local-data00"
      disk_size    = "80G"
    },
    {
      name         = "postgres"
      clone        = "ubuntu-22.04"
      cores        = 4
      memory       = 4096
      ipconfig0 = format("ip=%s/%d,gw=%s", local.dns.a_records["postgres"], local.network.cidr_bits, local.network.gateway)
      vmid         = 7631
      storage_pool = "local-data01"
      disk_size    = "100G"
    },
  ]
}
