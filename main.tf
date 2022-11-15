resource "proxmox_vm_qemu" "preprovision-test" {
  os_type           = "other"
  preprovision      = true
  ssh_forward_ip    = "10.0.125.51"
  target_node       = "ultron"
  iso               = "local:iso/fedora-coreos-36.20221014.3.1-live.x86_64.iso"
  ssh_user          = "terraform"
  cores             = 4
  sockets           = 1
  memory            = 16384 # 16 GB Minimum Required for OKD Master Node
  ssh_private_key   = <<EOF
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEArzKpEWz+zSsqTQdPH3y5yQMf2yBeOfzxnffhfYpPbb6/3EwK
FLkCIGLWnjMK34BFcp/YkktHJ5C+xKEaV67afCXSdMYldr97f5SoMlZgADhxVMPZ
F9VAydOYBuH7Rmnqi37DL+RrinN8p3emt+dzRz/pHkqL88YQUgDUMG6YHEOhNQ63
5qUh5cXp7UISp0t83OMF77v0T0k7MOYYTk0Q6fDIzAEVe/oKoA6BZp+rL4OIuyCA
PJ/xn6qmdS/YFrQBM6C943gjnhU7cBuO6cYPpAk0zkQLZtAlNld3ZPdnK8q1uAE8
OoXGzYGj+gVPa61M0RqyHzM+9NjxGsWa7HQNQQIDAQABAoIBABZ9fWCkSk1SNjrv
LkQPgdYBFazOieoNw4KQ2JyCDdI7w2tnQ4AHg/NeXMiwKrwoPkIJrQaSrU6x8RtS
xwvsgVWgkVS2Pwbwa80j6zeTCP3eQQYtogfCM2/1PrXbeqM+Y4KGwk26l+eNDbp9
zKQdDRpfZPCjhzXC/kNYoeSZveMawPYfafBhwQvKvmFzoB5prOi5uv8VlxDre5Bt
jHu/P0JbjA+1Xp0bN6LE8sRNEUQjMWX/MvCj9IN94fZ0Qb4lBDz4BL1IJfo31zOi
cCZ/TzPPLtn2aqVlim8G3wFk5LXTUpxbAvUJxcQcXRF7hGMbejjoq14Q1Rpf5WJS
D5v9VAECgYEA4K/3RQYcklBlAs/9GWbUgEVwelLWc0BCWz6ldW+x9kHZWdxq1UXZ
1rnZeYNuigWOJgUbE9qjgZRIhrNLDeoUFbLBiEPXUmUr59+kv68Wueu97thFFiMv
yqxkPkn8RsjtXXc2D1tO11T+B+XsSFVxY44NOqZ2qy4Tz0zz9qQbfaECgYEAx50W
t3CnrUQEe/96qeQ9jqOZgMknKmGQdd+I/9JKUI7+UQv20q7Aewr6aHY6+KgSu72k
BZFWQnp/kMqPL8uX918G5dwYHzNwkixFpII9enG3nHdnGS0aaPHqw0aejto04EAi
vZ8jnnEOFklUs/8U5BuPFhN+MUVqfblEBt8QK6ECgYEAm0W/kbm5gPuB8sGdXTKM
4+AY7M/WV2su8DOI0HFSAKZc+Ba01ZIiCpwAyFKlz0grhea9YakUmXXJ8RxyX7lG
DACucebAJLa58tHA3p63C+D4LtjSVYwXeO5NkCY86wXr002Q1Gf7QiAANaEU+p/h
bjU6uy9SjtWW5wl9BxM91EECgYBZgqvJHo9SNwn7wJh0zpB8Agi3o3wYmR96e/6n
GNmSPkz0cvT/jLVrd4TKixnunw+neGawyHdx4BSMDQkgWZ+PoeEp+gQnGZ4FLi0c
k/qViaDYXQKyW3NYVAL+BhDb5iWH2bq6ZT5HslKq079T57Kqh2EmeR9BYOtb7VP/
8M8DgQKBgQCNIC/sIcwS0j4pN9C2EQ8/Y7uW1ulWXlYutZHD3YeBvHuoC+7RDO0n
0iB9ZvI1+6yYq78PXtHrc6EvLbn28Noh12zb6XZFaRYwvIry08z5dWR7aJaGrhm6
SMLdaeuhJAX2Smgq79sA341f5Owo5aclualnCJ5e3wd9ppx5+edcIg==
-----END RSA PRIVATE KEY-----
EOF
  os_network_config = <<EOF
auto eth0
iface eth0 inet dhcp
EOF

  disk {
    storage = "local-lvm"
    type    = "virtio"
    size    = "200G"
  }

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  connection {
    type        = "ssh"
    user        = "${self.ssh_user}"
    private_key = "${self.ssh_private_key}"
    host        = "${self.ssh_host}"
    port        = "${self.ssh_port}"
  }
}
# resource "proxmox_vm_qemu" "okd-master-node" {
#   name        = "okd-master-1-node"
#   desc        = "Utilized to setup an OKD Master Node"
#   target_node = var.proxmox_host
#   vmid        = 101
#   iso         = "fedora-coreos-36.20221014.3.1-live.x86_64.iso"
#   agent       = 1
#   os_type     = "cloud-init"
#   ipconfig0   = "ip=10.0.125.51/16,gw=10.0.125.1"
#   cores       = 4
#   sockets     = 1
#   cpu         = "host"
#   memory      = 16384
#   scsihw      = "virtio-scsi-pci"
#   bootdisk    = "scsi0"
#   sshkeys     = var.ssh_key

#   // Setting up the Network
#   network {
#     bridge = "vmbr0"
#     model  = "virtio"
#   }

  # disk {
  #   storage = "local-lvm"
  #   type    = "virtio"
  #   size    = "200G"
  # }
# }
