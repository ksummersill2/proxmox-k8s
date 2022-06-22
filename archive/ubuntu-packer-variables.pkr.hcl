variable "proxmox-url" {
    type = string
    default = ""
    sensitive = true
}

variable "proxmox-username" {
    type = string
    default = ""
    sensitive = true
}

variable "proxmox-token" {
    type = string
    default = ""
    sensitive = true
}

variable "proxmox-node-name" {
    type = string
    default = ""
    sensitive = false
}

variable "iso-location" {
    type = string
    default = ""
    sensitive = false
}

variable "insecure" {
    type = bool
    default = false
}

variable "iso-storage-pool" {
    type = string
    default = ""
}

variable "ssh-username" {
    type = string
    default = ""
}

variable "vm-id" {
    type = string
    default = ""
}
