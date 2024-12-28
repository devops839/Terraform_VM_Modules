terraform {
  backend "azurerm" {
    resource_group_name   = "vault-rg"
    storage_account_name  = "demosaterraform"
    container_name        = "tf839"
    key                   = "demo3.terraform.tfstate"
  }
}
