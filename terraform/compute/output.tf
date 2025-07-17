# compute/outputs.tf

output "ssh_private_key" {
  value     = tls_private_key.vm_ssh.private_key_pem
  sensitive = true
}

output "vm_public_ip" {
  value = azurerm_public_ip.vm_dev_ip.ip_address
}