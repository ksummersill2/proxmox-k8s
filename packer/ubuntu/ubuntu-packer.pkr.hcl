source "proxmox-iso" "ubuntu-server" {
    proxmox_url              = var.proxmox-url
    username                 = var.proxmox-username
    token                    = var.proxmox-token
    node                     = var.proxmox-node-name
    // iso_url = "https://releases.ubuntu.com/22.04/ubuntu-22.04-live-server-amd64.iso"
    // iso_checksum = "sha256:84aeaf7823c8c61baa0ae862d0a06b03409394800000b3235854a6b38eb4856f"
    iso_file                 = var.iso-location
    iso_storage_pool         = var.iso-storage-pool
    insecure_skip_tls_verify = var.insecure
    vm_id                    = var.vm-id

    ssh_username             = var.ssh-username
    
    vm_name = "test"
    memory     = 500
    cores      = 1
    sockets    = 1
    cpu_type = "host"

    disks {
        type = "scsi"
        disk_size = "30G"
        storage_pool = "local-lvm"
        storage_pool_type = "lvm"
        format = "raw"
    }
    network_adapters {
        bridge   = "vmbr0"
        model    = "virtio"
        firewall = true
    }

}
build {
    name    = "ubuntu-server"
    sources = ["source.proxmox-iso.ubuntu-server"]
}