locals {
  machine_map = {
    machines = {
      m1 = {
        name        = "talos-dns",
        target_node = "ultron",
        os_type     = "cloud-init"
        agent       = 1        # Set to 1 to enable the QEMU Guest Agent. Note, you must run the qemu-guest-agent daemon in the guest for this to have any effect.
        full_clone  = true     # Set to true to create a full clone, or false to create a linked clone. See the docs about cloning for more info. Only applies when clone is set.
        template    = "VM 500" # Name of Template Used to Clone
        cores       = 4,
        socket      = 1,
        memory      = 6144,
        storage     = "150G",
        ip_address  = "10.0.125.110"
        gateway     = "10.0.125.1"
        description = "Load Balancer for Talos DNS"
        ssh_user    = "talosadmin"
      }
    }
  }

  machines = lookup(local.machine_map, "machines", {})
}
