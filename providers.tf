
provider "proxmox" {
    pm_api_url = "https://195.150.0.118:8006/api2/json"
    pm_api_token_id = "terraform@pam!terraform1"
    pm_api_token_secret = "a6cbe378-ac27-4fb9-adb4-18d0b802a6a0"
    pm_tls_insecure = true
    pm_debug = true
}