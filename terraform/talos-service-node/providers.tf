
provider "proxmox" {
  pm_api_url          = "https://10.0.125.81:8006/api2/json"
  pm_api_token_id     = "terraform@pve!iac"
  pm_api_token_secret = "f8592ccf-6029-4c5f-8123-e6c7c20d9b4a"
  pm_tls_insecure     = true
  pm_debug            = true
}
