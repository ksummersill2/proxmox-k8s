resource "proxmox_vm_qemu" "k8s-master-1-node" {
  name        = "k8s-master-1-node"
  target_node = var.proxmox_host
  iso         = "pfSense-CE-2.5.1-RELEASE-amd64.iso"
  agent = 0
  os_type = "ubuntu"
  cores = 2
  sockets = 1
  cpu = "host"
  memory = 2048
  scsihw = "virtio-scsi-pci"
  bootdisk = "scsi0"
}