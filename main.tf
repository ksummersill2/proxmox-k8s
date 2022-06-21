resource "proxmox_vm_qemu" "k8s-master-1-node" {
  name        = "k8s-master-1-node"
  desc        = "Utilized to setup an Ubuntu K8s Master Node"
  target_node = var.proxmox_host
  vmid        = 401
  iso         = "pfSense-CE-2.5.1-RELEASE-amd64.iso"
  agent       = 1
  os_type     = "other"
  cores       = 2
  sockets     = 1
  cpu         = "host"
  memory      = 2048
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "scsi0"
  sshkeys     = var.ssh_key

  // Setting up the Network
  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  disk {
    storage = "local-lvm"
    type    = "virtio"
    size    = "100G"

  }
}
