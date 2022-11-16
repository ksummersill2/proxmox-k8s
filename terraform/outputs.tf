output "okd_services_private_key" {
  value     = tls_private_key.okd_machine_keys.private_key_pem
  sensitive = true
}

# Access the Key by running terraform output -raw okd_services_private_key
