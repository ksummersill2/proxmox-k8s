
provider "proxmox" {
  pm_api_url          = "https://<url to proxmox>:8006/api2/json"
  pm_api_token_id     = "<your-pve>@pve!<your-pve>"
  pm_api_token_secret = "<your secret for the api pve account>"
  pm_tls_insecure     = true
  pm_debug            = true
}
