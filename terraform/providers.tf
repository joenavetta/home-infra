terraform {
  required_providers {
    proxmox = {
      source  = "Telmate/proxmox"
      version = "3.0.1-rc3"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.37"
    }
    onepassword = {
      source  = "1Password/onepassword"
      version = "~> 2.1"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://pve-01.cowshed.cc:8006/api2/json"
  pm_debug   = true
}

provider "cloudflare" {
  api_token = data.onepassword_item.cloudflare.credential
}

provider "onepassword" {
  account = "PW5WK2EEO5HM5L4UG46ABS37TA"
}