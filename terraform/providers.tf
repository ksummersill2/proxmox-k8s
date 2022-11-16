
provider "proxmox" {
  pm_api_url          = "https://10.0.125.81:8006/api2/json"
  pm_api_token_id     = "yoda@pve!yoda"
  pm_api_token_secret = "574fcf32-bd6b-4abe-908a-b186738b5bd9"
  pm_tls_insecure     = true
  pm_debug            = true
}
