
provider "proxmox" {
  pm_api_url          = "https://10.0.125.81:8006/api2/json"
  pm_api_token_id     = "yoda@pve!yoda2"
  pm_api_token_secret = "9b6e13bf-3ed6-40ef-9ccb-5f9403bfb100"
  pm_tls_insecure     = true
  pm_debug            = true
}
