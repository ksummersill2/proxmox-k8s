locals {
  machine_map = {
    machines = {
      m1 = {
        name        = "okd-bastion",
        target_node = "ultron",
        os_type     = "cloud-init"
        agent       = 1        # Set to 1 to enable the QEMU Guest Agent. Note, you must run the qemu-guest-agent daemon in the guest for this to have any effect.
        full_clone  = true     # Set to true to create a full clone, or false to create a linked clone. See the docs about cloning for more info. Only applies when clone is set.
        template    = "VM 500" # Name of Template Used to Clone
        cores       = 4,
        socket      = 1,
        memory      = 4096,
        storage     = "150G",
        ip_address  = "10.0.125.101"
        gateway     = "10.0.125.1"
        description = "Bastion Node for the OKD Cluster"
        ssh_user    = "okdadmin"
      }
    }
  }

  machines = lookup(local.machine_map, "machines", {})
}
