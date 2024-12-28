terraform {
  backend "azurerm" {
    resource_group_name   = "demorg"
    storage_account_name  = "demosaterraform"
    container_name        = "tf839"
    key                   = "demo.terraform.tfstate"
  }
}