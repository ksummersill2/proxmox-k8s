resource "tls_private_key" "okd_machine_keys" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "proxmox_vm_qemu" "okd_machines" {
  depends_on = [
    tls_private_key.okd_machine_keys
  ]
  for_each         = local.machines
  name             = each.value.name
  qemu_os          = "other"
  desc             = each.value.description
  target_node      = each.value.target_node
  os_type          = each.value.os_type
  full_clone       = each.value.full_clone
  clone            = each.value.template
  memory           = each.value.memory
  sockets          = each.value.socket
  cores            = each.value.cores
  ssh_user         = each.value.ssh_user
  sshkeys          = tls_private_key.okd_machine_keys.public_key_openssh
  ciuser           = each.value.ssh_user
  ipconfig0        = "ip=10.0.125.31/32,gw=10.0.125.1"
  cipassword       = "Reggie11!"
  automatic_reboot = true

  disk {
    storage = "local-lvm"
    type    = "virtio"
    size    = each.value.storage
  }

  network {
    bridge  = "vmbr0"
    model   = "virtio"
    mtu     = 0
    macaddr = "7A:63:04:A3:50:94"
    queues  = 0
    rate    = 0
  }

  provisioner "remote-exec" {
    inline = [
      "sudo dnf install firewalld",
      "sudo systemctl enable --now firewalld",
      "sudo firewall-cmd --permanent --add-port=6443/tcp",
      "sudo firewall-cmd --permanent --add-port=2379-2380/tcp",
      "sudo firewall-cmd --permanent --add-port=10250/tcp",
      "sudo firewall-cmd --permanent --add-port=10251/tcp",
      "sudo firewall-cmd --permanent --add-port=10252/tcp",
      "sudo firewall-cmd --permanent --add-port=10255/tcp",
      "sudo firewall-cmd --permanent --add-port=8472/udp",
      "sudo firewall-cmd --add-masquerade --permanent",
      "sudo firewall-cmd --permanent --add-port=30000-32767/tcp # only if you want NodePorts exposed on control plane IP as well",
      "sudo systemctl restart firewalld"
    ]
    connection {
      type        = "ssh"
      user        = each.value.ssh_user
      private_key = tls_private_key.okd_machine_keys.private_key_pem
      host        = each.value.ip_address
      timeout     = "5m"
    }
  }
}
