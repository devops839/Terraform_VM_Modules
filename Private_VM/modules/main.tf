provider "azurerm" {
  features {}
}

/* data "azurerm_key_vault" "kv" {
  name                = "demo-vault839"
  resource_group_name = "vault-rg"
}

# Fetch secrets from Azure Key Vault (admin username & password)
data "azurerm_key_vault_secret" "admin_username" {
  name         = "vmuser"  # Correct the secret name
  key_vault_id = var.key_vault_id  # Use the consolidated Key Vault ID variable
}

data "azurerm_key_vault_secret" "admin_password" {
  name         = "vmpasswd"  # Correct secret name
  key_vault_id = var.key_vault_id  # Use the consolidated Key Vault ID variable
}
*/
# Resource Group
data "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
}

# Virtual Network
resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.1.0.0/16"]
}

# Subnet
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.1.0.0/24"]
}

# Network Interface
resource "azurerm_network_interface" "nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Virtual Machine (RHEL9)
resource "azurerm_linux_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = var.location
  resource_group_name   = var.resource_group_name
  size                  = "Standard_DS1_v2"
//  admin_username        = data.azurerm_key_vault_secret.admin_username.value  # Use Key Vault secret value for username
//  admin_password        = data.azurerm_key_vault_secret.admin_password.value  # Use Key Vault secret value for password
  admin_username        = "vmadmin"
  admin_password        = "vmadmin@1234"
  network_interface_ids = [azurerm_network_interface.nic.id]
  # Enable password authentication
  disable_password_authentication = false
  os_disk {
    name                 = var.vm_disk_name
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "9_0"
    version   = "latest"
  }

  provision_vm_agent = true
}

# Outputs
output "vm_ids" {
  value = azurerm_linux_virtual_machine.vm.id
}

output "private_ips" {
  value = azurerm_network_interface.nic.private_ip_address
}
