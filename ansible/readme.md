# Check Local Inventory for Proxmox
```
ansible-inventory -i ansible/inventories/proxmox.yml --graph
```

# Setting up the SSH Key
Make sure to run the following for the key.pem used to connect:
```
chmod 600 keys/key.pem 
```

# Running the Plabook
