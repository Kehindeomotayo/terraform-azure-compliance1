# compute/outputs.tf

output "vm_public_ip" {
  value = azurerm_public_ip.vm_dev_ip.ip_address
}