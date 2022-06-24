packer {
  required_plugins {
    proxmox = {
      version = ">= 1.0.8"
      source  = "github.com/hashicorp/proxmox"
    }
  }
}