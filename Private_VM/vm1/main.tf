module "vm" {
  source               = "../modules"  # Call the module in the modules directory
  resource_group_name  = var.resource_group_name
  location             = var.location
  virtual_network_name = var.virtual_network_name
  subnet_name          = var.subnet_name
  nic_name             = var.nic_name
  vm_name              = var.vm_name
  vm_disk_name         = var.vm_disk_name
//  key_vault_id         = var.key_vault_id  # Pass the Key Vault ID here
}
